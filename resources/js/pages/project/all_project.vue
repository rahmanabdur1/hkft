<template>
  <div style="position: relative">
    <h2 class="hkf_title text-center mb-4">All Project</h2>
    <div class="row">
      <div class="input-group col-md-6 page_to_page">
        <router-link :to="{ name: 'add_project' }" class="btn btn-primary"
          >Add Project</router-link
        >
      </div>
      <div class="input-group col-md-6 page_to_page">
        <router-link :to="{ name: 'create_building' }" class="btn btn-primary"
          >Create Building</router-link
        >
      </div>
      <div class="input-group col-md-6">
        <input
          type="search"
          v-model="searchTerm"
          class="form-control rounded"
          placeholder="Search by location"
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
          <th>Project Name <i class="fa fa-sort" @click="sorting_asc"></i></th>
          <th>Project Location</th>
          <th>Project Code</th>
          <th>Building</th>
          <th>Project Status</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(project, index) in filterSearch" :key="index">
          <td>{{ ++index }}</td>
          <td>{{ project.project_name }}</td>
          <td>{{ project.project_address }}</td>
          <td>{{ project.project_code }}</td>
          <td>
            <button type="button" class="btn" @click="passProjectId(project.id)">
              <i class="fas fa-eye"></i>
            </button>
          </td>
          <td
            v-if="project.project_status == 'completed'"
            class="text-success status_project"
          >
            {{ project.project_status }}
          </td>
          <td
            v-if="project.project_status == 'upcoming'"
            class="text-info status_project"
          >
            {{ project.project_status }}
          </td>
          <td v-if="project.project_status == 'on-hold'" class="text-info status_project">
            {{ project.project_status }}
          </td>
          <td
            v-if="project.project_status == 'in-progress'"
            class="text-warning status_project"
          >
            {{ project.project_status }}
          </td>
          <td class="remove_bg_td">
            <router-link
              class="action btn"
              :to="{ name: 'edit_project', params: { id: project.id } }"
              >Edit</router-link
            >
            <router-link
              class="action btn ml-2"
              :to="{ name: 'view_project', params: { id: project.id } }"
              >View</router-link
            >
          </td>
        </tr>

        <!-- add more rows as needed -->
      </tbody>
    </table>

    <div class="customModal" id="exampleModal">
      <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
          <div class="modal-body">
            <button
              type="button"
              class="btn-close"
              aria-label="Close"
              @click="closePopUp"
            >
              X
            </button>
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
                <tr v-for="(project, index) in allBuildings" :key="index">
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
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "all_project",
  data() {
    return {
      allBuildings: [],
      projects: [],
      sorting: false,
      searchTerm: "",
      showModal: false,
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
              this.showModal = false;
              this.projects = this.projects.filter((item) => {
                return item.id != id;
              });
              location.reload();
            })
            .catch((err) => {
              console.log(err.response);
            });

          Swal.fire("Deleted!", "Your file has been deleted.", "success");
        }
      });
    },
    closePopUp() {
      document.querySelector(".customModal").style.display = "none";
    },
    fetchProjects(url) {
      axios
        .get(url)
        .then((res) => {
          this.projects = res.data;
        })
        .catch((error) => {});
    },
    passProjectId(id) {
      this.showModal = true;
      document.querySelector(".customModal").style.display = "block";
      axios
        .get("/api/get_building_data/" + id)
        .then((res) => {
          this.allBuildings = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
  },
  created() {
    this.fetchProjects("/api/project");
  },
  computed: {
    filterSearch() {
      return this.projects.filter((project) => {
        const search_Term = this.searchTerm.toLowerCase();
        const typeName = project.project_address.toLowerCase();
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
        vm.$router.push({ name: "all_project" });
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
.customModal {
  display: none;
  position: absolute;
  width: 80%;
  left: 10%;
  right: 10%;
  top: 30%;
  height: auto;
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
