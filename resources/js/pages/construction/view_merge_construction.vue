<template>
  <div>
    <h2 class="hkf_title text-center mb-4">Construction Lists</h2>
    <div class="row">
      <div class="col-md-6 page_to_page">
        <router-link :to="{ name: 'required_construction' }" class="btn btn-primary"
          >Add Construction Cost</router-link
        >
      </div>

      <div class="input-group col-md-6" style="display: block">
        <div style="display: flex">
          <input
            type="text"
            class="form-control status"
            placeholder="Client Name,Phone "
            v-model="client_search"
            @keyup="listDisplay"
          />

          <button
            type="button"
            @click="searchByAll"
            class="btn btn-primary"
            style="height: 38px"
          >
            Search
          </button>
        </div>
        <div>
          <ul class="ulShow" :class="{ listStyle: list_style }">
            <li
              class="listShow"
              :class="{ listStyle: list_style }"
              v-for="(item, index) in filterSearch"
              :key="index"
              :value="item.client_name"
              @click="assignToSearch(item.client_name)"
            >
              {{ item.client_name }}
            </li>
          </ul>
        </div>
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

    <table class="table">
      <thead>
        <tr>
          <th>SL</th>
          <th>Date <i class="fa fa-sort" @click="sorting_asc"></i></th>
          <th>Client Name</th>
          <th>Client ID</th>
          <th>Phone</th>
          <th>Share</th>
          <th>Required Amount</th>
          <th>Due Amount</th>
          <th>Purpose</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(project, index) in filterSearch" :key="index">
          <td>{{ ++index }}</td>
          <td>{{ project.basic_date }}</td>
          <td>{{ project.client_name }}</td>
          <td>{{ project.client_id }}</td>
          <td>{{ project.phone }}</td>
          <td>{{ project.share }}</td>
          <td>{{ project.required_amount }} tk</td>
          <td>{{ project.due }} tk</td>
          <td>{{ project.note }}</td>
          <td class="remove_bg_td">
            <router-link
              class="action btn mx-2 my-1"
              :to="{ name: 'edit_required_construction', params: { id: project.id } }"
              >Edit</router-link
            >
            <router-link
              class="action btn mx-2 my-1"
              :to="{ name: 'view_required_construction', params: { id: project.id } }"
              >View</router-link
            >
            <router-link
              class="action btn mx-2 my-1"
              :to="{ name: 'pay_construction', params: { id: project.id } }"
              >Pay</router-link
            >
            <button
              class="action_danger btn"
              type="button"
              @click="deleteEntry(project.id)"
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
            .delete("/api/construction/" + id)
            .then((res) => {
              this.projects = this.projects.filter((res) => {
                return res.id != id;
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
            this.projects = res.data;
            axios.get("/api/project").then((res) => {
              this.admin = true;
              this.manager = false;
              this.allprojects = res.data;
              axios
                .get("/api/getMergeGroup/" + this.$route.params.id)
                .then((res) => {
                  this.projects = res.data;
                  console.log(this.projects);
                })
                .catch((err) => {
                  console.log(err.response);
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
                axios
                  .get("/api/getMergeGroup/" + this.$route.params.id)
                  .then((res) => {
                    console.log(res.data);
                    this.projects = res.data;

                    console.log(this.projects);
                  })
                  .catch((err) => {
                    console.log(err.response);
                  });
              })
              .catch((err) => {});
          }
          console.log(res.data);
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
        const info = {
          client: this.client_search,
          project: this.selectedProject,
          building: this.selectedBuilding,
          startDate: this.startDate,
          endDate: this.endDate,
        };
        axios
          .post("/api/clientBaseSearchRequiredConstructionManager/", info, {
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
      }
    },
  },
  created() {
    let id = this.$route.params.id;

    this.fetchProjects("/api/view_merge_construction/" + id);
  },
  computed: {
    filterSearch() {
      return this.projects.filter((project) => {
        const search_Term = this.client_search.toLowerCase();
        const phone = project.phone.toLowerCase();
        const typeName = project.client_name.toLowerCase();
        return typeName.includes(search_Term) || phone.includes(search_Term);
      });
    },
    chooseProject() {
      axios
        .get("/api/constructionSelectedProject/" + this.selectedProject)
        .then((res) => {
          this.projects = res.data;
          console.log(res.data);
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
      axios
        .get("/api/constructionFetchByBuildings/" + this.selectedBuilding)
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
        vm.$router.push({ name: "view_merge_construction" });
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
