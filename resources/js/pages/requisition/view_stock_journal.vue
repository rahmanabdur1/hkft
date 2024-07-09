<template>
  <div>
    <h2 class="hkf_title text-center mb-4">Stocks</h2>
    <div class="row">
      <div class="input-group col-md-6 page_to_page"></div>
      <div class="input-group col-md-6" style="display: block">
        <div style="display: flex">
          <input
            type="text"
            class="form-control status"
            placeholder="Product Name"
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
              :value="item.product_name"
              @click="assignToSearch(item.product_name)"
            >
              {{ item.product_name }}
            </li>
          </ul>
        </div>
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
            v-for="(project, index) in projects"
            :key="index"
            :value="project.project"
          >
            {{ project.project }}
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
            v-for="(project, index) in projects"
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
            :value="project.selectedBuilding"
          >
            {{ project.selectedBuilding }}
          </option>
        </select>
      </div>
    </div>
    <!-- <div class="row">
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
    </div> -->
    <table class="table">
      <thead>
        <tr>
          <th>Product Name</th>
          <th>Project</th>
          <th>Building</th>
          <th>Quantity</th>
          <th>Unit</th>
          <th>Transfer</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="account_head in filterSearch" :key="account_head.id">
          <td>{{ account_head.product_name }}</td>
          <td>
            {{ account_head.project }}
          </td>
          <td>
            {{ account_head.selectedBuilding }}
          </td>
          <td>
            {{ account_head.quantity }}
          </td>

          <td>
            {{ account_head.unit }}
          </td>
          <td>
            <router-link
              class="btn action_danger"
              style="width: 150px; text-align: center"
              :to="{ name: 'stock_transfer', params: { id: account_head.id } }"
              >Stock Transfer</router-link
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
      account_heads: [],
      sorting: false,
      client_search: "",
      list_style: true,
      okStartDate: "",
      okEndDate: "",
      admin: false,
      manager: false,
      selectedProject: "",
      selectedBuilding: "",
      projects: [],
      buildings: [],
      isBuilding: false,
    };
  },
  computed: {
    filterSearch() {
      const voucher = this.account_heads.filter((project) => {
        const search_Term = this.client_search.toLowerCase();
        const typeName = project.product_name.toLowerCase();
        return typeName.match(search_Term);
      });

      return voucher;
    },
    chooseProject() {
      this.isBuilding = true;
      axios
        .get("/api/fetchSelectedStockProject/" + this.selectedProject)
        .then((res) => {
          this.account_heads = res.data;
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
        .get("/api/fetchStockProjectBuilding/" + this.selectedBuilding)
        .then((res) => {
          this.account_heads = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
  },
  methods: {
    searchByAll() {
      const info = {
        product_name: this.client_search,
        project: this.selectedProject,
        building: this.selectedBuilding,
        startDate: this.okStartDate,
        endDate: this.okEndDate,
      };
      axios
        .post("/api/stockBaseDateAll", info, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.account_heads = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    sendDate() {
      const info = {
        startDate: this.okStartDate,
        endDate: this.okEndDate,
      };
      axios
        .post("/api/stockBaseDate", info, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.account_heads = res.data.forEach((item1) => {
            this.projects.filter((item2) => {
              return item1.project == item2.project;
            });
          });
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    removeList() {
      this.list_style = true;
    },
    listDisplay() {
      this.list_style = false;
    },
    assignToSearch(item) {
      this.client_search = item;
      this.list_style = true;
    },
    fetchProjects() {
      if (User.getGuard() == "admin") {
        this.admin = true;
        this.manager = false;
        axios
          .get("/api/getStocks")
          .then((res) => {
            this.account_heads = res.data;
            console.log(res.data);
            this.account_heads.forEach((eachProduct, index) => {
              axios
                .get("/api/getUnit/" + eachProduct.product_name)
                .then((res) => {
                  this.account_heads[index].unit = res.data.item_unit;
                })
                .catch((err) => {});

              axios
                .get("/api/fetchAdminStock")
                .then((res) => {
                  this.projects = res.data;
                  console.log(res.data);
                })
                .catch((err) => {
                  console.log(err.response);
                });
            });
          })
          .catch((error) => {
            console.log(error);
          });
      } else if (User.getGuard() == "manager") {
        this.admin = false;
        this.manager = true;
        axios.get("/api/fetchManagerProject/" + User.getUserName()).then((res) => {
          this.projects = res.data;
          console.log(this.projects);
        });

        const promises = [];
        axios
          .get("/api/getManagerProject/" + User.getUserName())
          .then((res) => {
            res.data.forEach((item) => {
              promises.push(
                axios.get("/api/fetchManagerStock/" + item.project).then((res) => {
                  return res.data;
                })
              );
            });

            Promise.all(promises).then((res) => {
              this.account_heads = res.flat();
              this.account_heads.forEach((eachProduct, index) => {
                axios
                  .get("/api/getUnit/" + eachProduct.product_name)
                  .then((res) => {
                    this.account_heads[index].unit = res.data.item_unit;
                  })
                  .catch((err) => {});
              });
              console.log(this.account_heads);
            });
          })
          .catch((err) => {});
      }
    },
    deleteStock($id) {
      axios
        .delete("/api/requisition/" + $id)
        .then((res) => {
          location.reload();
        })
        .catch((err) => {
          console.log(err.response);
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

  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else {
        vm.$router.push({ name: "view_stock_journal" });
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
