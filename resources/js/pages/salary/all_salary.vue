<template>
  <div>
    <h2 class="hkf_title text-center mb-4">Salary Sheet</h2>
    <div class="row">
      <div class="input-group col-md-6 page_to_page">
        <router-link :to="{ name: 'add_employee' }" class="btn btn-primary"
          >Add Employee</router-link
        >
      </div>
      <div class="input-group col-md-6">
        <input
          type="search"
          v-model="searchTerm"
          class="form-control rounded"
          placeholder="Search by employee name"
          aria-label="Search"
          aria-describedby="search-addon"
        />
        <button
          type="button"
          @click="searchByEmployee"
          class="btn btn-primary"
          style="height: 38px"
        >
          Search
        </button>
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
            :value="project.selectedProject"
          >
            {{ project.selectedProject }}
          </option>
        </select>
      </div>
      <div class="form-group col-md-3 mx-sm-3 mb-2" v-if="manager">
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
            v-for="(project, index) in Projects"
            :key="index"
            :value="project.project"
          >
            {{ project.project }}
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
    <form @submit.prevent="totalExpense()" class="mt-5">
      <div class="form-row">
        <div class="form-group col-md-3">
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
        <div class="form-group col-md-3">
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
        <div class="form-group col-md-3" style="margin-top: 30px">
          <button type="submit" class="btn btn-primary" style="height: 38px">
            Search
          </button>
        </div>
      </div>
    </form>

    <table class="table">
      <thead>
        <tr style="font-size: 0.8em">
          <th>Date</th>

          <th>Employee Name <i class="fa fa-sort" @click="sorting_asc"></i></th>

          <th>Project</th>
          <th>Building</th>
          <th>Contact</th>
          <th>Basic Salary</th>
          <th>Gross Salary</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <tr
          v-for="(project, index) in filterSearch"
          :key="index"
          style="font-size: 0.8em"
        >
          <td>{{ project.basic_date }}</td>

          <td>{{ project.employee_name }}</td>
          <td>{{ project.selectedProject }}</td>
          <td>{{ project.selectedBuilding }}</td>
          <td>{{ project.employee_phone }}</td>
          <td>{{ project.basic_salary }} tk</td>
          <td>{{ parseInt(project.basic_salary) + parseInt(project.commission) }} tk</td>
          <td class="remove_bg_td">
            <router-link
              class="action btn"
              style="font-size: 0.8em; width: 40px"
              :to="{ name: 'edit_salary', params: { id: project.id } }"
              >Edit</router-link
            >
            <router-link
              class="action btn ml-2"
              style="font-size: 0.8em; width: 40px"
              :to="{ name: 'view_salary', params: { id: project.id } }"
              >View</router-link
            >

            <button
              type="button"
              style="font-size: 0.8em; width: 40px"
              class="action_danger btn ml-2"
              @click="deleteEmployee(project.id)"
            >
              Delete
            </button>
          </td>
        </tr>
        <tr>
          <td>Total Salary:</td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td>{{ totalSalary }}tk</td>
        </tr>
        <!-- add more rows as needed -->
      </tbody>
    </table>
  </div>
</template>
<script>
export default {
  name: "salary_sheet",
  data() {
    return {
      selectedBuilding: "",
      projects: [],
      sorting: false,
      searchTerm: "",
      startDate: "",
      endDate: "",
      total_salary: "",
      isBuilding: false,
      buildings: [],
      selectedProject: "",
      fetchprojects: [],
      Projects: [],
      okStartDate: "",
      okEndDate: "",
      totalSalary: 0,
    };
  },
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else {
        vm.$router.push({ name: "salary_sheet" });
      }
    });
  },
  methods: {
    sendDate() {
      const data = {
        startDate: this.okStartDate,
        endDate: this.okEndDate,
      };
      axios
        .post("/api/fetchAllExpenseByDate", data, {
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
          const nameA = a.product_name.toUpperCase();
          const nameB = b.product_name.toUpperCase();
          if (nameA > nameB) {
            return -1;
          }
          if (nameA > nameB) {
            return 1;
          }
          return 0;
        });
      } else {
        return this.projects.sort((a, b) => {
          const nameA = a.product_name.toUpperCase();
          const nameB = b.product_name.toUpperCase();
          if (nameA < nameB) {
            return -1;
          }
          if (nameA < nameB) {
            return 1;
          }
          return 0;
        });
      }
    },
    deleteEmployee(id) {
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
            .delete("/api/salary/" + id)
            .then((res) => {
              this.projects = this.projects.filter((item) => {
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
    fetchProjects(url) {
      //admin  & manager
      this.guard = User.getGuard();
      if (this.guard == "admin") {
        this.admin = true;
        this.manager = false;

        axios
          .get(url)
          .then((res) => {
            this.projects = res.data;
            console.log(this.projects);
            this.totalSalary = 0;
            this.projects.forEach((item) => {
              this.totalSalary += parseInt(item.basic_salary) + parseInt(item.commission);
            });
          })
          .catch((error) => {
            console.log(error);
          });

        axios
          .get("/api/fetchAdminEmployee")
          .then((res) => {
            this.fetchprojects = res.data;
          })
          .catch((err) => {
            console.log(err.response);
          });
      } else if (this.guard == "manager") {
        this.manager = true;
        this.admin = false;
        axios.get("/api/fethProjectPurchaseManager/" + User.getUserName()).then((res) => {
          this.Projects = res.data;
          console.log(this.Projects);
        });

        this.manager_username = User.getUserName();
        axios
          .get("/api/getManagerProject/" + this.manager_username)
          .then((res) => {
            const promises = [];

            res.data.forEach((item) => {
              promises.push(
                axios.get("/api/manager_fetch_salary/" + item.project).then((res) => {
                  return res.data;
                })
              );
            });
            Promise.all(promises).then((res) => {
              this.projects = res.flat();
              console.log(this.projects);
              this.totalSalary = 0;
              this.projects.forEach((item) => {
                this.totalSalary +=
                  parseInt(item.basic_salary) + parseInt(item.commission);
              });
            });
          })
          .catch((err) => {
            console.log(err.response);
          });
      }

      //end
    },
    searchByEmployee() {
      const requestData = {
        startDate: this.startDate,
        endDate: this.endDate,
        selectedProject: this.selectedProject,
        selectedBuilding: this.selectedBuilding,
        employee_name: this.searchTerm,
      };
      axios
        .post("/api/salary/searchByEmployee", requestData, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.projects = res.data;
          console.log(this.projects);
          this.totalSalary = 0;
          this.projects.forEach((item) => {
            this.totalSalary += parseInt(item.basic_salary) + parseInt(item.commission);
          });
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    totalExpense() {
      const requestData = {
        startDate: this.startDate,
        endDate: this.endDate,
      };
      axios
        .post("/api/salary/fetchSalary", requestData, {
          headers: {
            "Content-Type": "multipart/form-data",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.projects = res.data;
          this.totalSalary = 0;
          this.projects.forEach((item) => {
            this.totalSalary += parseInt(item.basic_salary) + parseInt(item.commission);
          });
          console.log(res.data);
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
  },
  created() {
    this.fetchProjects("/api/salary");
  },
  computed: {
    filterSearch() {
      const salary = this.projects.filter((project) => {
        const search_Term = this.searchTerm.toLowerCase();
        const typeName = project.employee_name.toLowerCase();
        return typeName.match(search_Term);
      });
      this.totalSalary = 0;
      salary.forEach((item) => {
        this.totalSalary += parseInt(item.basic_salary) + parseInt(item.commission);
      });
      return salary;
    },
    chooseProject() {
      this.isBuilding = true;
      axios
        .get("/api/fetchAdminEmployeeByProjectSalary/" + this.selectedProject)
        .then((res) => {
          this.projects = res.data;
          this.totalSalary = 0;
          this.projects.forEach((item) => {
            this.totalSalary += parseInt(item.basic_salary) + parseInt(item.commission);
          });
          this.isBuilding = true;
          axios
            .get("/api/fetchBuildingInventory/" + this.selectedProject)
            .then((res) => {
              this.buildings = res.data;
              console.log(this.buildings);
            })
            .catch((err) => {
              console.log(err.response);
            });
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    chooseBuilding() {
      axios
        .get("/api/fetchemployeeallbuildingsSalary/" + this.selectedBuilding)
        .then((res) => {
          this.projects = res.data;
          this.totalSalary = 0;
          this.projects.forEach((item) => {
            this.totalSalary += parseInt(item.basic_salary) + parseInt(item.commission);
          });
          console.log(res.data);
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
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
