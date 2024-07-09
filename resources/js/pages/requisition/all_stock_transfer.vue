<template>
  <div>
    <h2 class="hkf_title text-center mb-4">Transfered Stocks</h2>
    <div class="row">
      <div class="input-group col-md-6"></div>
      <div class="input-group col-md-6">
        <input
          type="search"
          v-model="searchTerm"
          class="form-control rounded"
          placeholder="Search by Product Name"
          aria-label="Search"
          aria-describedby="search-addon"
        />
        <button
          type="button"
          @click="sendAll"
          class="btn btn-primary"
          style="height: 38px"
        >
          Search
        </button>
      </div>
    </div>
    <div class="row">
      <div class="form-group col-md-4 mx-sm-3 mb-2" v-if="isAdmin">
        <label for="projectName" class="hkf_text">Transfer From Project</label>
        <select
          class="form-control status"
          id="status"
          v-model="selectedFromProject"
          onfocus="this.size=10"
          onblur="this.size=1"
          onchange="this.size=1;this.blur();"
          @change="chooseFromProject"
          required
        >
          <option
            v-for="(project, index) in projects"
            :key="index"
            :value="project.project_name"
          >
            {{ project.project_name }}
          </option>
        </select>
      </div>
      <div class="form-group col-md-3 mx-sm-3 mb-2" v-if="isManager">
        <label for="projectName" class="hkf_text">Transfer From Project</label>
        <select
          class="form-control status"
          id="status"
          v-model="selectedFromProject"
          onfocus="this.size=10"
          onblur="this.size=1"
          onchange="this.size=1;this.blur();"
          @change="chooseFromProject"
          required
        >
          <option
            v-for="(project, index) in projects"
            :key="index"
            :value="project.project"
          >
            {{ project.project }}
          </option>
        </select>
      </div>
      <div class="form-group col-md-4 mx-sm-3 mb-2" v-if="isBuilding">
        <label for="projectName" class="hkf_text">Transfer From Building</label>
        <select
          class="form-control status"
          id="status"
          v-model="selectedFromBuilding"
          onfocus="this.size=10"
          onblur="this.size=1"
          onchange="this.size=1;this.blur();"
          @change="chooseFromBuilding"
          required
        >
          <option
            v-for="(project, index) in buildings"
            :key="index"
            :value="project.fromBuilding"
          >
            {{ project.fromBuilding }}
          </option>
        </select>
      </div>
    </div>
    <div class="row">
      <div class="form-group col-md-4 mx-sm-3 mb-2" v-if="isAdmin">
        <label for="projectName" class="hkf_text">Transfer To Project</label>
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
            v-for="(project, index) in projects"
            :key="index"
            :value="project.project_name"
          >
            {{ project.project_name }}
          </option>
        </select>
      </div>
      <div class="form-group col-md-3 mx-sm-3 mb-2" v-if="isManager">
        <label for="projectName" class="hkf_text">Transfer To Project</label>
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
            v-for="(project, index) in projects"
            :key="index"
            :value="project.project"
          >
            {{ project.project }}
          </option>
        </select>
      </div>
      <div class="form-group col-md-4 mx-sm-3 mb-2" v-if="isBuildingTo">
        <label for="projectName" class="hkf_text">Transfer To Building</label>
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
            v-for="(project, index) in tobuildings"
            :key="index"
            :value="project.selectedBuilding"
          >
            {{ project.selectedBuilding }}
          </option>
        </select>
      </div>
    </div>
    <div class="row">
      <form @submit.prevent="sendDate" class="col-md-12">
        <div class="row">
          <div class="form-group col-md-5">
            <label for="" class="hkf_text">Start Date</label>
            <input
              type="date"
              v-model="okStartDate"
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
              v-model="okEndDate"
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
          <th>Date</th>
          <th>T. from Project</th>
          <th>T. from Building</th>
          <th>T. to Project</th>
          <th>T. to Building</th>
          <th>Product</th>
          <th>Quantity</th>

          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(account_head, index) in filterSearch" :key="account_head.id">
          <td>{{ index + 1 }}</td>
          <td>{{ account_head.basic_date }}</td>

          <td>{{ account_head.fromProject }}</td>

          <td>{{ account_head.fromBuilding }}</td>
          <td>{{ account_head.selectedProject }}</td>

          <td>{{ account_head.selectedBuilding }}</td>
          <td>{{ account_head.product_name }}</td>

          <td>
            {{ account_head.quanity }}
          </td>

          <td class="remove_bg_td">
            <router-link
              class="btn"
              :to="{ name: 'edit_stock_transfer', params: { id: account_head.id } }"
              ><i class="fas fa-edit"></i
            ></router-link>
            <router-link
              class="btn"
              :to="{ name: 'view_stock_transfer', params: { id: account_head.id } }"
              ><i class="fas fa-eye"></i
            ></router-link>
            <button class="btn ml-2" @click="deleteStock(account_head.id)">
              <i class="fas fa-trash"></i>
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
  name: "all_stock_journal",
  data() {
    return {
      account_heads: [],
      sorting: false,
      searchTerm: "",
      isAdmin: false,
      projects: [],
      selectedProject: "",
      selectedFromProject: "",
      selectedFromBuilding: "",
      buildings: [],
      tobuildings: [],
      selectedBuilding: "",
      okStartDate: "",
      okEndDate: "",
      isBuilding: false,
      isManager: false,
      isBuildingTo: false,
    };
  },

  methods: {
    sendDate() {
      const requestData = {
        startDate: this.okStartDate,
        endDate: this.okEndDate,
        selectedProject: this.selectedProject,
        selectedBuilding: this.selectedBuilding,
        selectedFromProject: this.selectedFromProject,
        selectedFromBuilding: this.selectedFromBuilding,
      };
      axios
        .post("/api/fetchStockJournalByDateTransfer", requestData, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.account_heads = res.data;
          console.log(res.data);
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    sendAll() {
      const data = {
        startDate: this.okStartDate,
        endDate: this.okEndDate,
        selectedProject: this.selectedProject,
        selectedBuilding: this.selectedBuilding,
        selectedFromProject: this.selectedFromProject,
        selectedFromBuilding: this.selectedFromBuilding,

        product: this.searchTerm,
      };
      axios
        .post("/api/fetchStockJournalByDateProductTransfer", data, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.account_heads = res.data;
          console.log(res.data);
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    fetchProjects() {
      axios
        .get("/api/stock_transfer")
        .then((res) => {
          this.account_heads = res.data;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    deleteStock(id) {
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
            .delete("/api/stock_transfer/" + id)
            .then((res) => {
              this.account_heads = this.account_heads.filter((account_head) => {
                return account_head.id != id;
              });
              console.log(res.data);
            })
            .catch((err) => {
              console.log(err.response);
            });
          Swal.fire("Deleted!", "Your file has been deleted.", "success");
        }
      });
    },
    // setPage(page) {
    //   this.currentPage = page;
    //   this.fetchProjects();
    // },
  },
  created() {
    this.fetchProjects();
    if (User.getGuard() == "admin") {
      this.isAdmin = true;
      this.isManager = false;
      axios
        .get("/api/project")
        .then((res) => {
          this.projects = res.data;
        })
        .catch((err) => {});
    } else {
      this.isAdmin = false;
      this.isManager = true;
      axios.get("/api/fethProjectPurchaseManager/" + User.getUserName()).then((res) => {
        this.projects = res.data;
        console.log(this.projects);
      });
    }
    // axios
    //   .get("/api/fetchAllProjectFromStock")
    //   .then((res) => {
    //     this.projects = res.data;
    //     console.log(res.data);
    //   })
    //   .catch((err) => {
    //     console.log(err.response);
    //   });
  },

  computed: {
    filterSearch() {
      return this.account_heads.filter((account_head) => {
        const search_Term = this.searchTerm.toLowerCase();
        const typeName = account_head.product_name.toLowerCase();
        return typeName.match(search_Term);
      });
    },
    chooseFromProject() {
      this.isBuilding = true;
      axios
        .get("/api/fetchStockByProjectTransfer/" + this.selectedFromProject)
        .then((res) => {
          this.account_heads = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });
      axios
        .get("/api/fetchBuildingInStockTransfer/" + this.selectedFromProject)
        .then((res) => {
          this.buildings = res.data;
          console.log(res.data);
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    chooseProject() {
      this.isBuildingTo = true;
      axios
        .get("/api/fetchStockByProjectTransferTo/" + this.selectedProject)
        .then((res) => {
          this.account_heads = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });
      axios
        .get("/api/fetchBuildingInventory/" + this.selectedProject)
        .then((res) => {
          this.tobuildings = res.data;
          console.log(this.tobuildings);
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    chooseBuilding() {
      axios
        .get("/api/fetchStockByBuildingTransferedTo/" + this.selectedBuilding)
        .then((res) => {
          this.account_heads = res.data;
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
        vm.$router.push({ name: "all_stock_transfer" });
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
