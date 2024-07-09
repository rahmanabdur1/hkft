<template>
  <div >
    <h2 class="hkf_title text-center mb-4 ">Account Types</h2>
    <div class="row">
      <div class="input-group col-md-6 page_to_page">
        <router-link :to="{ name: 'add_account_type' }" class="btn btn-primary"
          >Add Account Type</router-link
        >
      </div>
      <div class="input-group col-md-6">
        <input
          type="search"
          v-model="searchTerm"
          class="form-control rounded"
          placeholder="Search by Type"
          aria-label="Search"
          aria-describedby="search-addon"
        />
        <button type="button" class="btn btn-primary" style="height: 38px">Search</button>
      </div>
    </div>
    <table class="table ">
      <thead>
        <tr>
          <th>Account Type  <i class="fa fa-sort" @click="sorting_asc"></i></th>
          
          <th>Account Status</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="account_type in filterSearch" :key="account_type.id">
          <td>{{ account_type.type_name }}</td>
          
          <td
            v-if="account_type.type_status == 'active'"
            class="text-success status_project"
          >
            {{ account_type.type_status }}
          </td>
          <td v-if="account_type.type_status == 'inactive'" class="text-info status_project">
            {{ account_type.type_status }}
          </td>
          
          <td class="remove_bg_td">
            <router-link
              class="action btn"
              :to="{ name: 'edit_account_type',params:{id:account_type.id} }"
              >Edit</router-link
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
  name: "all_project",
  data() {
    return {
      account_types: [],
      sorting: false,
      searchTerm: "",
    };
  },

  methods: {
    sorting_asc() {
      this.sorting = !this.sorting;
      if (this.sorting == true) {
        return this.projects.sort((a, b) => {
          const nameA = a.type_name.toUpperCase();
          const nameB = b.type_name.toUpperCase();
          if (nameA < nameB) {
            return -1;
          }
          if (nameA > nameB) {
            return 1;
          }
          return 0;
        });
      } else {
        return this.projects.sort((a, b) => {
          const nameA = a.type_name.toUpperCase();
          const nameB = b.type_name.toUpperCase();
          if (nameA > nameB) {
            return -1;
          }
          if (nameA < nameB) {
            return 1;
          }
          return 0;
        });
      }
    },
    fetchProjects(){
      axios
        .get("/api/account_type")
        .then((res) => {
          this.account_types = res.data;
          //  this.currentPage = res.data.current_page;
          // this.lastPage = res.data.last_page;
          
        })
        .catch((error) => {
          console.log(error);
        });
    },
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
      return this.account_types.filter((account_type) => {
        const search_Term = this.searchTerm.toLowerCase();
        const typeName = account_type.type_name.toLowerCase();
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
        vm.$router.push({ name: "account_type" });
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
  color: #63cb49  !important;
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
  display:inline;
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
.pagination li a :hover{
  background-color: #007bff;
  color: #ffffff;
}

</style>
