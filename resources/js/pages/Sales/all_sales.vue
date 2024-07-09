<template>
  <div>
    <h2 class="hkf_title text-center mb-4">Inventories</h2>
    <div class="row">
      <div class="input-group col-md-6 page_to_page">
        <router-link :to="{ name: 'create_sales' }" class="btn btn-primary"
          >Create Sales</router-link
        >
      </div>

      <div class="input-group col-md-6">
        <input
          type="search"
          v-model="searchTerm"
          class="form-control rounded"
          placeholder="Search by property name"
          aria-label="Search"
          aria-describedby="search-addon"
        />
        <button type="button" class="btn btn-primary" style="height: 38px">Search</button>
      </div>
    </div>
    <div class="row">
      <div class="form-group col-md-3 mx-sm-3 mb-2" v-if="admin">
        <label for="projectName" class="hkf_text">Select Project</label>
        <select
          class="form-control status"
          id="status"
          v-model="selectedProject"
          onfocus="this.size=10"
          onblur="this.size=1"
          onchange="this.size=1;this.blur();"
          @change="chooseProject"
          required
        >
          <option
            v-for="(project, index) in fetchprojects"
            :key="index"
            :value="project.property_project"
          >
            {{ project.property_project }}
          </option>
        </select>
      </div>
      <div class="form-group col-md-4 mx-sm-3 mb-2" v-if="isBuilding">
        <label for="projectName" class="hkf_text">Select Building</label>
        <select
          class="form-control status"
          id="status"
          v-model="selectedBuilding"
          onfocus="this.size=10"
          onblur="this.size=1"
          onchange="this.size=1;this.blur();"
          @change="chooseBuilding"
          required
        >
          <option
            v-for="(project, index) in buildings"
            :key="index"
            :value="project.building_name"
          >
            {{ project.building_name }}
          </option>
        </select>
      </div>
    </div>
    <table class="table">
      <thead>
        <tr>
          <th>SL</th>
          <th>Property Name <i class="fa fa-sort" @click="sorting_asc"></i></th>
          <th>Property Project</th>
          <th>Building Name</th>
          <th>Property Location</th>
          <th>Property Status</th>
          <th>Owner</th>
          <th>Client ID</th>
          <th>Phone</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(project, index) in filterSearch" :key="index">
          <td>{{ ++index }}</td>
          <td>{{ project.property_name }}</td>
          <td v-if="project.property_project != 0">{{ project.property_project }}</td>
          <td v-else>Land</td>
          <td>{{ project.building_name }}</td>
          <td>{{ project.location }}</td>

          <td
            v-if="project.property_status == 'Available'"
            class="text-success status_project"
          >
            {{ project.property_status }}
          </td>
          <td v-if="project.property_status == 'Sold'" class="text-danger status_project">
            {{ project.property_status }}
          </td>
          <td v-if="project.owner">{{ project.owner }}</td>
          <td v-else></td>
          <td>{{ project.client_id }}</td>
          <td>{{ project.phone }}</td>
          <td class="remove_bg_td">
            <router-link
              class="action btn mr-2"
              :to="{ name: 'view_sales', params: { id: project.id } }"
              >View</router-link
            >
            <router-link
              class="action btn"
              :to="{ name: 'edit_sales', params: { id: project.id } }"
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
  name: "all_project",
  data() {
    return {
      projects: [],
      sorting: false,
      searchTerm: "",
      selectedProject: "",
      buildings: [],
      selectedBuilding: "",
      fetchprojects: [],
      isBuilding: false,
    };
  },

  methods: {
    sorting_asc() {
      this.sorting = !this.sorting;
      if (this.sorting == true) {
        return this.projects.sort((a, b) => {
          const nameA = a.property_name.toUpperCase();
          const nameB = b.property_name.toUpperCase();
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
          const nameA = a.property_name.toUpperCase();
          const nameB = b.property_name.toUpperCase();
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
    this.fetchProjects("/api/inventory");
    if (User.getGuard() == "admin") {
      this.admin = true;
      axios
        .get("/api/fetchInventoryProject")
        .then((res) => {
          this.fetchprojects = res.data;
          console.log(res.data);
        })
        .catch((err) => {
          console.log(err.response);
        });
    }
  },
  computed: {
    filterSearch() {
      return this.projects.filter((project) => {
        const search_Term = this.searchTerm.toLowerCase();
        const typeName = project.property_name.toLowerCase();
        if (project.phone && project.client_id) {
          let phones = project.phone.toLowerCase();
          let client_id = project.client_id.toLowerCase();
          return (
            typeName.includes(search_Term) ||
            phones.includes(search_Term) ||
            client_id.includes(search_Term)
          );
        }
        if (project.phone && !project.client_id) {
          let phones = project.phone.toLowerCase();
          return typeName.includes(search_Term) || phones.includes(search_Term);
        }
        if (!project.phone && project.client_id) {
          let client_id = project.client_id.toLowerCase();
          return typeName.includes(search_Term) || client_id.includes(search_Term);
        }

        return typeName.match(search_Term);
      });
    },
    chooseProject() {
      this.isBuilding = true;
      axios
        .get("/api/fetchBuildingInventory/" + this.selectedProject)
        .then((res) => {
          this.buildings = res.data;
          axios.get("/api/fetchDataByProject/" + this.selectedProject).then((res) => {
            this.projects = res.data;
          });
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    chooseBuilding() {
      axios.get("/api/fetchDataByBuilding/" + this.selectedBuilding).then((res) => {
        this.projects = res.data;
      });
    },
  },
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else {
        vm.$router.push({ name: "all_sales" });
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
