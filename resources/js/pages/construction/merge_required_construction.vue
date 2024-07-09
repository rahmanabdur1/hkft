<template>
  <div>
    <h2 class="hkf_title text-center mb-4">Construction Lists</h2>
    <div class="row">
      <div class="col-md-6 page_to_page">
        <router-link :to="{ name: 'required_construction' }" class="btn btn-primary"
          >Add Construction Cost</router-link
        >
      </div>
    </div>
    <div class="row">
      <form @submit.prevent="passDate" class="col-md-12">
        <div class="row">
          <div class="form-group col-md-5">
            <label for="" class="hkf_text">Start Date</label>
            <input
              type="date"
              v-model="startDate"
              class="form-control rounded"
              aria-label="Search"
              aria-describedby="search-addon"
              required
            />
          </div>
          <div class="form-group col-md-5">
            <label for="" class="hkf_text">End Date</label>
            <input
              type="date"
              v-model="endDate"
              class="form-control rounded"
              aria-label="Search"
              aria-describedby="search-addon"
              required
            />
          </div>
          <div class="form-group col-md-2" style="margin-top: 30px">
            <button type="submit" class="btn btn-primary" style="height: 38px">
              Search
            </button>
          </div>
        </div>
      </form>
    </div>
    <div class="row">
      <div class="form-group col-md-4 mx-sm-3 mb-2" v-if="admin">
        <label for="projectName" class="hkf_text">Select Project </label>
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
            v-for="(project, index) in allprojects"
            :key="index"
            :value="project.project_name"
          >
            {{ project.project_name }}
          </option>
        </select>
      </div>
      <div class="form-group col-md-4 mx-sm-3 mb-2" v-if="manager">
        <label for="projectName" class="hkf_text">Select Project </label>
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
            v-for="(project, index) in allProjects"
            :key="index"
            :value="project.project"
          >
            {{ project.project }}
          </option>
        </select>
      </div>
      <div class="form-group col-md-4 mx-sm-3 mb-2">
        <label for="projectName" class="hkf_text">Select Building </label>
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
          <th>Date <i class="fa fa-sort" @click="sorting_asc"></i></th>
          <th>Client Name</th>
          <th>Project</th>
          <th>Buildling</th>
          <th>Purpose</th>
          <th>Required Amount</th>
          <th>Due Date</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(project, index) in projects" :key="index">
          <td>{{ ++index }}</td>
          <td>{{ project.basic_date }}</td>
          <td v-if="project.select_type == 'one'">{{ project.client_name }}</td>
          <td v-else>All Client</td>
          <td>{{ project.selectedProject }}</td>
          <td>{{ project.selectedBuilding }}</td>
          <td>{{ project.note }}</td>
          <td>{{ project.required_amount }} tk</td>
          <td>{{ project.due_date }}</td>
          <td class="remove_bg_td">
            <router-link
              class="action btn mr-2"
              :to="{
                name: 'view_merge_construction',
                params: { id: project.construction_id },
              }"
              >View</router-link
            >
            <router-link
              class="action btn mr-2"
              :to="{
                name: 'pay_merge_construction',
                params: { id: project.construction_id },
              }"
              >Pay</router-link
            >
            <router-link
              class="action btn mr-2"
              :to="{
                name: 'edit_merge_construction',
                params: { id: project.construction_id },
              }"
              >Edit</router-link
            >
            <button
              class="action_danger btn"
              type="button"
              @click="deleteEntry(project.construction_id)"
            >
              Delete
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
  data() {
    return {
      projects: [],
      sorting: true,
      searchTerm: "",
      selectedBuilding: "",
      selectedProject: "",
      buildings: "",
      allProjects: [],
      allprojects: [],
      startDate: "",
      endDate: "",
      admin: false,
      manager: false,
      list_style: true,
      client_search: "",
    };
  },

  methods: {
    listDisplay() {
      this.list_style = false;
    },
    assignToSearch(item) {
      this.client_search = item;
      this.list_style = true;
    },
    deleteEntry(id) {
      Swal.fire({
        title: "Are you sure?",
        text: "You won't be able to revert this!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Yes, delete it!",
      }).then((result) => {
        if (result.isConfirmed) {
          axios
            .delete("/api/delete_merge_construction/" + id)
            .then((res) => {
              this.projects = this.projects.filter((res) => {
                return res.construction_id != id;
              });
            })
            .catch((err) => {
              console.log(err.response);
            });

          Swal.fire("Deleted!", "Your file has been deleted.", "success");
        }
      });
    },
    passDate() {
      const requestData = {
        startDate: this.startDate,
        endDate: this.endDate,
      };
      axios
        .post("/api/fetchConstructionByDate", requestData, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.projects = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    sorting_asc() {
      this.sorting = !this.sorting;
      if (this.sorting == true) {
        return this.projects.sort((a, b) => {
          const nameA = a.basic_date.toUpperCase();
          const nameB = b.basic_date.toUpperCase();
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
          const nameA = a.basic_date.toUpperCase();
          const nameB = b.basic_date.toUpperCase();
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
          if (User.getGuard() == "admin") {
            axios.get("/api/project").then((res) => {
              this.admin = true;
              this.manager = false;
              this.allprojects = res.data;
              let promises = this.allprojects.map((item) => {
                return axios
                  .get("/api/constructionAll/" + item.project_name)
                  .then((res) => {
                    console.log(res.data);
                    if (res.data && res.data.length != 0) {
                      return res.data;
                    } else {
                      return []; // or any default value you prefer
                    }
                  })
                  .catch((err) => {
                    console.log(err.response);
                  });
              });
              console.log(this.projects);
              Promise.all(promises)
                .then((results) => {
                  this.projects = results.flat(); // Flatten the array of arrays
                  console.log("Fetched projects:", this.projects);
                })
                .catch((err) => {
                  console.log("Error fetching projects:", err);
                });
            });
          } else if (User.getGuard() == "manager") {
            this.manager = true;
            this.admin = false;
            let manager_name = User.getUserName();
            axios
              .get("/api/getManagerProject/" + manager_name)
              .then((res) => {
                this.allProjects = res.data;
                console.log(this.allProjects);

                let promises = this.allProjects.map((item) => {
                  console.log(item.project);
                  return axios
                    .get("/api/constructionAll/" + item.project)
                    .then((res) => {
                      console.log(res.data);
                      if (res.data && res.data.length > 0) {
                        return res.data;
                      } else {
                        return [];
                      }
                    })
                    .catch((err) => {
                      console.log(err.response);
                    });
                });

                Promise.all(promises).then((results) => {
                  this.projects = results.flat();
                  console.log(this.projects);
                });
              })
              .catch((err) => {});
          }
        })
        .catch((error) => {});
    },
    searchByAll() {
      if (User.getGuard() == "admin") {
        const info = {
          client: this.client_search,
          project: this.selectedProject,
          building: this.selectedBuilding,
          startDate: this.startDate,
          endDate: this.endDate,
        };
        axios
          .post("/api/clientBaseSearchRequiredConstruction", info, {
            headers: {
              "Content-Type": "application/json",
              Accept: "application/json",
            },
          })
          .then((res) => {
            this.projects = res.data;
          })
          .catch((err) => {
            console.log(err.response);
          });
      } else {
        axios
          .get("/api/clientBaseSearchRequiredConstructionManager/" + this.client_search)
          .then((res) => {
            this.projects = res.data;
          })
          .catch((err) => {
            console.log(err.response);
          });
      }
    },
  },
  created() {
    this.fetchProjects("/api/mergeConstruction");
  },
  computed: {
    // filterSearch() {
    //   return this.projects.filter((project) => {
    //     const search_Term = this.client_search.toLowerCase();
    //     const typeName = project.client_name.toLowerCase();
    //     return typeName.match(search_Term);
    //   });
    // },
    chooseProject() {
      this.selectedBuilding = "";
      axios
        .get("/api/constructionSelectedProject1/" + this.selectedProject)
        .then((res) => {
          this.projects = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/fetchBuildingInventory/" + this.selectedProject)
        .then((res) => {
          this.buildings = res.data;
          console.log(this.buildings);
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    chooseBuilding() {
      alert(this.selectedBuilding);
      axios
        .get("/api/constructionFetchByBuildings1/" + this.selectedBuilding)
        .then((res) => {
          this.projects = res.data;
          console.log(this.projects);
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
  },
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else {
        vm.$router.push({ name: "merge_required_construction" });
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
