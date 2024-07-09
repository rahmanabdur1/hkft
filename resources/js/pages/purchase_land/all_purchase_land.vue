<template>
  <div>
    <h2 class="hkf_title text-center mb-4">Land Details Lists</h2>
    <div class="row">
      <div class="input-group col-md-6 page_to_page">
        <router-link :to="{ name: 'add_purchase_land' }" class="btn btn-primary"
          >Add Land Details</router-link
        >
      </div>
      <div class="input-group col-md-6">
        <input
          type="search"
          v-model="searchTerm"
          class="form-control rounded"
          placeholder="Search by Daag No."
          aria-label="Search"
          aria-describedby="search-addon"
        />
        <button type="button" class="btn btn-primary" style="height: 38px">Search</button>
      </div>
    </div>
    <table class="table">
      <thead>
        <tr>
          <th>Land Office <i class="fa fa-sort" @click="sorting_asc"></i></th>
          <th>District</th>
          <th>Thana</th>
          <th>Ledger No.</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="project,index in filterSearch"  :key='index'>
          <td>{{ project.land_office }}</td>
          <td>{{ project.district }}</td>
          <td>
            {{ project.thana }}
          </td>
          <td>
            {{ project.ledger_no }}
          </td>
          <td class="remove_bg_td">
            <router-link
              class="action btn mr-2"
              :to="{ name: 'view_purchase_land', params: { id: project.id } }"
              >View</router-link
            ><router-link
              class="action btn"
              :to="{ name: 'edit_purchase_land', params: { id: project.id } }"
              >Edit</router-link
            >
          </td>
        </tr>

        <!-- add more rows as needed -->
      </tbody>
    </table>
  </div>
</template>
<script>
export default {
  name: "all_purchase_land",
  data() {
    return {
      projects: [],
      sorting: false,
      searchTerm: "",
    };
  },

  methods: {
    sorting_asc() {
      this.sorting = !this.sorting;
      if (this.sorting == true) {
        return this.projects.sort((a, b) => {
          const nameA = a.project_address.toUpperCase();
          const nameB = b.project_address.toUpperCase();
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
          const nameA = a.project_address.toUpperCase();
          const nameB = b.project_address.toUpperCase();
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
        .catch((error) => {
          console.log(error);
        });
    },
  },
  created() {
    this.fetchProjects("/api/purchase_land_details");
  },
  computed: {
    filterSearch() {
      return this.projects.filter((project) => {
        const search_Term = this.searchTerm;
        const typeName = project.dag_no;
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
        vm.$router.push({ name: "all_purchase_land" });
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
