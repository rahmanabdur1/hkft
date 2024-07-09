<template>
  <div>
    <h2 class="hkf_title text-center mb-4">Extra Pay Lists</h2>
    <div class="row">
      <div class="col-md-6 page_to_page">
        <router-link :to="{ name: 'advance_pay' }" class="btn btn-primary"
          >Add Extra Payment</router-link
        >
      </div>
      <div class="input-group col-md-6" style="display: block">
        <div style="display: flex">
          <input
            type="text"
            class="form-control status"
            placeholder="Client Name"
            v-model="client_search"
            @keyup="listDisplay"
            @mouseup="removeList"
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
              :value="item.client_id"
              @click="assignToSearch(item.client_id)"
            >
              {{ item.client_id }}
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
    <div class="row">
      <div class="form-group col-md-4 mx-sm-3 mb-2">
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
            :value="project.selectedProject"
          >
            {{ project.selectedProject }}
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
            :value="project.selectedBuilding"
          >
            {{ project.selectedBuilding }}
          </option>
        </select>
      </div>
    </div>
    <table class="table">
      <thead>
        <tr>
          <th>Date <i class="fa fa-sort" @click="sorting_asc"></i></th>
          <th>Client Name</th>
          <th>Project</th>
          <th>Buildling</th>
          <th>Amount</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(project, index) in filterSearch" :key="index">
          <td>{{ project.basic_date }}</td>
          <td>{{ project.client_name }}</td>
          <td>{{ project.selectedProject }}</td>
          <td>{{ project.selectedBuilding }}</td>
          <td>{{ project.amount }} tk</td>

          <td class="remove_bg_td">
            <router-link
              class="action btn mr-2"
              :to="{ name: 'edit_advance_pay', params: { id: project.id } }"
              >Edit</router-link
            >
            <router-link
              class="action btn mr-2"
              :to="{ name: 'view_advance_pay', params: { id: project.id } }"
              >View</router-link
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
        <tr>
          <td>Total:</td>
          <td></td>
          <td></td>
          <td></td>

          <td>{{ totalAmount }} tk</td>

          <td class="remove_bg_td"></td>
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
      sorting: true,
      searchTerm: "",
      selectedBuilding: "",
      selectedProject: "",
      buildings: "",
      allprojects: [],
      startDate: "",
      endDate: "",
      list_style: true,
      client_search: "",
      totalAmount: "",
    };
  },

  methods: {
    listDisplay() {
      this.list_style = false;
    },
    removeList() {
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
            .get("/api/deleteFromTotal/" + id)
            .then((res) => {})
            .catch((err) => {
              console.log(err.response);
            });

          axios
            .delete("/api/advance_pay/" + id)
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
        .post("/api/fetchAdvanceByDate", requestData, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.projects = res.data;
          this.totalAmount = 0;
          this.projects.forEach((item) => {
            this.totalAmount += parseInt(item.amount);
          });
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
          this.projects = res.data;
          this.totalAmount = 0;

          this.projects.forEach((item) => {
            this.totalAmount += parseInt(item.amount);
          });
        })
        .catch((error) => {});
    },
    assignToSearch(item) {
      this.client_search = item;
      this.list_style = true;
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
          .post("/api/clientBaseSearchAdvance", info, {
            headers: {
              "Content-Type": "application/json",
              Accept: "application/json",
            },
          })
          .then((res) => {
            this.projects = res.data;
            this.totalAmount = 0;

            this.projects.forEach((item) => {
              this.totalAmount += parseInt(item.amount);
            });
          })
          .catch((err) => {
            console.log(err.response);
          });
      } else {
        axios
          .get("/api/clientBaseSearchAdvanceManager/" + this.client_search)
          .then((res) => {
            this.projects = res.data;
            this.totalAmount = 0;

            this.projects.forEach((item) => {
              this.totalAmount += parseInt(item.amount);
            });
          })
          .catch((err) => {
            console.log(err.response);
          });
      }
    },
  },
  created() {
    this.fetchProjects("/api/advance_pay");
    axios.get("/api/projectFromAdvancePay").then((res) => {
      this.allprojects = res.data;
    });
  },
  computed: {
    filterSearch() {
      return this.projects.filter((project) => {
        const search_Term = this.client_search.toLowerCase();
        const typeName = project.client_id.toLowerCase();
        return typeName.match(search_Term);
      });
    },
    chooseProject() {
      axios
        .get("/api/advancePaysSelectedProject/" + this.selectedProject)
        .then((res) => {
          this.projects = res.data;
          this.totalAmount = 0;

          this.projects.forEach((item) => {
            this.totalAmount += parseInt(item.amount);
          });
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
        .get("/api/advancePaysFetchByBuildings/" + this.selectedBuilding)
        .then((res) => {
          this.projects = res.data;
          this.totalAmount = 0;

          this.projects.forEach((item) => {
            this.totalAmount += parseInt(item.amount);
          });
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
      } else if (User.getGuard() == "manager") {
        vm.$router.push({ name: "manager_dashboard" });
      } else {
        vm.$router.push({ name: "all_advance_pay" });
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
