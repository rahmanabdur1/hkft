<template>
  <div>
    <h2 class="hkf_title text-center mb-4">All Building</h2>
    <div class="row">
      <div class="input-group col-md-6 page_to_page">
        <router-link :to="{ name: 'create_building' }" class="btn btn-primary"
          >Add Building</router-link
        >
      </div>
      <div class="input-group col-md-6">
        <input
          type="search"
          v-model="searchTerm"
          class="form-control rounded"
          placeholder="Search by building"
          aria-label="Search"
          aria-describedby="search-addon"
        />
        <button type="button" class="btn btn-primary" style="height: 38px">Search</button>
      </div>
    </div>
    <table class="table">
      <thead>
        <tr>
          <th>SL</th>
          <th>Building Name <i class="fa fa-sort" @click="sorting_asc"></i></th>
          <th>Average Flat Size</th>
          <th>Floor Area Size</th>
          <th>Building Height</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(project, index) in filterSearch" :key="index">
          <td>{{ ++index }}</td>
          <td>{{ project.building_name }}</td>
          <td>{{ project.average_flat_size }}</td>
          <td>{{ project.floor_area_size }}</td>
          <td>
            {{ project.building_height }}
          </td>
          <td class="remove_bg_td">
            <router-link
              class="btn"
              :to="{ name: 'edit_building', params: { id: project.id } }"
            >
              <i class="fa fa-edit"></i
            ></router-link>
            <router-link
              class="btn ml-2"
              :to="{ name: 'view_building', params: { id: project.id } }"
            >
              <i class="fa fa-eye"></i
            ></router-link>
            <button class="btn" @click="deleteBuilding(project.id)">
              <i class="fa fa-trash"></i>
            </button>
          </td>
        </tr>

        <!-- add more rows as needed -->
      </tbody>
    </table>
  </div>
</template>
<script>
export default {
  name: "index_building",
  data() {
    return {
      projects: [],
      sorting: false,
      searchTerm: "",
    };
  },

  methods: {
    deleteBuilding(id) {
      Swal.fire({
        title: "Are you sure?",
        text: "You won't be able to revert this!",
        icon: "Danger",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Yes, delete it!",
      }).then((result) => {
        if (result.isConfirmed) {
          axios
            .delete("/api/building/" + id)
            .then((res) => {
              //reload the page
              console.log(res.data);
              this.projects = this.projects.filter((item) => {
                console.log(item);
                return item.id != id;
              });
            })
            .catch((err) => {
              console.log(err.response);
            });

          Swal.fire("Deleted!", "Your file has been deleted.", "success");
        }
      });
    },
    sorting_asc() {
      this.sorting = !this.sorting;
      if (this.sorting == true) {
        return this.projects.sort((a, b) => {
          const nameA = a.building_name.toUpperCase();
          const nameB = b.building_name.toUpperCase();
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
          const nameA = a.building_name.toUpperCase();
          const nameB = b.building_name.toUpperCase();
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
    fetchProjects(url) {
      axios
        .get(url)
        .then((res) => {
          this.projects = res.data;
        })
        .catch((error) => {});
    },
  },
  created() {
    this.fetchProjects("/api/building");
  },
  computed: {
    filterSearch() {
      return this.projects.filter((project) => {
        const search_Term = this.searchTerm.toLowerCase();
        const typeName = project.building_name.toLowerCase();
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
        vm.$router.push({ name: "index_building" });
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
  color: #66a756 !important;
}
.page_to_page {
  margin-bottom: 1rem;
}
table tr:nth-child(even) .remove_bg_td {
  background: white;
}
</style>
