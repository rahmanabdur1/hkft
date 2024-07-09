<template>
  <div>
    <h2 class="hkf_title text-center mb-4">Manager Registered Project </h2>
    <div class="row">
      <div class="input-group col-md-6 page_to_page">
        <router-link :to="{ name: 'add_manager_approve' }" class="btn btn-primary"
          >Add Manager
        </router-link>
      </div>
      <div class="input-group col-md-6">
        <input
          type="search"
          v-model="searchTerm"
          class="form-control rounded"
          placeholder="Search by Name"
          aria-label="Search"
          aria-describedby="search-addon"
        />
        <button type="button" class="btn btn-primary" style="height: 38px">Search</button>
      </div>
    </div>
    <table class="table">
      <thead>
        <tr>
          <th>Manager Name <i class="fa fa-sort" @click="sorting_asc"></i></th>
          <th>Project</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="reference in filterSearch" :key="reference.id">
          <td>{{ reference.manager_name }}</td>
          <td>{{ reference.project }}</td>

          <td class="remove_bg_td">
            <router-link
              class="action btn"
              :to="{ name: 'edit_manager_approve', params: { id: reference.id } }"
              >Edit</router-link
            >
            <button
              class="action_danger btn ml-2"
                @click='deleteManager(reference.id)'
              >Delete</button
            >

          </td>
        </tr>

        <!-- add more rows as needed -->
      </tbody>

      <!-- <div class='pagination'>
      <ul v-if="lastPage > 1">
      <li v-for="page in lastPage" :key="page" :class="{ 'active': page === currentPage }">
        <router-link :to="{name:'account_type'}" @click.prevent="setPage(page)">{{ page }}</router-link>
      </li>
    </ul>
    </div> -->
    </table>
  </div>
</template>
<script>
export default {
  name: "all_reference",
  data() {
    return {
      references: [],
      sorting: false,
      searchTerm: "",
    };
  },

  methods: {
    sorting_asc() {
      this.sorting = !this.sorting;
      if (this.sorting == true) {
        return this.references.sort((a, b) => {
          const nameA = a.manager_name.toUpperCase();
          const nameB = b.manager_name.toUpperCase();
          if (nameA > nameB) {
            return 1;
          }
          if (nameA < nameB) {
            return -1;
          }
          return 0;
        });
      } else {
        return this.references.sort((a, b) => {
          const nameA = a.manager_name.toUpperCase();
          const nameB = b.manager_name.toUpperCase();
          if (nameA < nameB) {
            return 1;
          }
          if (nameA > nameB) {
            return -1;
          }
          return 0;
        });
      }
    },
    fetchProjects() {
      axios
        .get("/api/manager_approve")
        .then((res) => {
          this.references = res.data;
          //  this.currentPage = res.data.current_page;
          // this.lastPage = res.data.last_page;
        })
        .catch((error) => {
        });
    },
    deleteManager(id){
        Swal.fire({
  title: 'Are you sure?',
  text: "You won't be able to revert this!",
  icon: 'warning',
  showCancelButton: true,
  confirmButtonColor: '#3085d6',
  cancelButtonColor: '#d33',
  confirmButtonText: 'Yes, delete it!'
}).then((result) => {
  if (result.isConfirmed) {

    axios.delete('/api/manager_approve/'+id).then((res)=>{
            this.references = this.references.filter((res)=>{
            return res.id!=id;
});
        });

    Swal.fire(
      'Deleted!',
      'Your file has been deleted.',
      'success'
    )
  }
})



    }
    // setPage(page) {
    //   this.currentPage = page;
    //   this.fetchProjects();
    // },
  },
  created() {
    this.fetchProjects();
  },
  computed: {
    filterSearch() {
      return this.references.filter((reference) => {
        const search_Term = this.searchTerm.toLowerCase();
        const typeName = reference.manager_name.toLowerCase();
        return typeName.match(search_Term);
      });
    },
  },
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else if (User.getGuard() == "manager") {
        vm.$router.push({ name: "manager_dashboard" });
      } else {
        vm.$router.push({ name: "all_manager_approve" });
      }
    });
  },
};
</script>
<style>
.hkf_text {
  color: #4e3089 !important;
}
th {
  font-weight: bold;
  color: #473b5edb;
}
table tr:nth-child(even) {
  background-color: #605ca8 !important;
  color: white;
}
.action {
  color: white;
  background: #5d57c3;
  padding: 5px;
  width: 60px;
}
table tr:nth-child(odd) {
  color: #473b5edb;
  font-weight: bold;
}
.status_project {
  font-weight: bold;
  font-size: 1.2rem;
}
.text-warning {
  color: #35354c !important;
}
.text-info {
  color: #36becc !important;
}
.text-success {
  color: #63cb49 !important;
}
.page_to_page {
  margin-bottom: 1rem;
}
table tr:nth-child(even) .remove_bg_td {
  background: white;
}
.pagination {
  display: flex;
  justify-content: center;
  margin-top: 20px;
}

.pagination li {
  list-style: none;
  margin: 0 5px;
  display: inline;
}

.pagination li.active a {
  color: #ffffff;
  background-color: #007bff;
  border: 1px solid #007bff;
}

.pagination li a {
  color: #007bff;
  background-color: #ffffff;
  border: 1px solid #007bff;
  padding: 6px 12px;
  text-decoration: none;
  cursor: pointer;
  margin-right: 5px;
}
.pagination li a :hover {
  background-color: #007bff;
  color: #ffffff;
}
</style>
