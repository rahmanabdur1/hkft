<template>
  <div>
    <h2 class="hkf_title text-center mb-4">All Receipt Voucher</h2>
    <div class="row">
      <div class="col-md-6 page_to_page">
        <router-link :to="{ name: 'receipt_voucher' }" class="btn btn-primary"
          >Create Receipt Voucher</router-link
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
    <div class="row">
      <div class="form-group col-md-4 mx-sm-3 mb-2" v-if="isAdmin">
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
            :value="project.selectedProject"
          >
            {{ project.selectedProject }}
          </option>
        </select>
      </div>
      <div class="form-group col-md-3 mx-sm-3 mb-2" v-if="isManager">
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
            :value="project.building_name"
          >
            {{ project.building_name }}
          </option>
        </select>
      </div>
    </div>

    <table class="table">
      <thead>
        <tr class="header_table">
          <th>SL <i class="fa fa-sort" @click="sorting_asc"></i></th>
          <th>Date</th>
          <th>FS Year</th>
          <th>Voucher No</th>
          <th>Depositors Name</th>
          <th>Client ID</th>
          <th>Product Name</th>
          <th>Total Amount</th>
          <th>Paid Amount</th>
          <th>Due Amount</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(receipt, index) in filterSearch" :key="index">
          <td>{{ index + 1 }}</td>
          <td>{{ receipt.basic_date }}</td>
          <td>{{ receipt.financialYear }}</td>
          <td>
            {{ receipt.receipt_id }}
          </td>
          <td>
            {{ receipt.client_name }}
          </td>
          <td>
            {{ receipt.client_id }}
          </td>
          <td>
            {{ receipt.product_name }}
          </td>
          <td>
            {{ receipt.product_amount }}
          </td>
          <td>
            {{ receipt.total_amount }}
          </td>
          <td>
            {{ receipt.due }}
          </td>
          <td class="action_td">
            <router-link
              class="btn"
              :to="{ name: 'edit_voucher', params: { id: receipt.id } }"
              ><i class="fas fa-edit"></i
            ></router-link>
            <router-link
              class="btn"
              :to="{ name: 'view_voucher', params: { id: receipt.id } }"
              ><i class="fa fa-eye"></i
            ></router-link>
            <router-link
              class="btn"
              :to="{ name: 'print_voucher', params: { id: receipt.id } }"
              ><i class="fa fa-print"></i
            ></router-link>
            <button class="btn" @click="deleteVoucher(receipt.receipt_id)">
              <i class="fa fa-trash"></i>
            </button>
          </td>
        </tr>
        <!-- add more rows as needed -->
      </tbody>
    </table>
    <div class="col-md-12 text-right">
      <span class="hkf_texts mr-4">Total Cost: {{ cost }} tk</span>
    </div>
  </div>
</template>
<script>
export default {
  name: "all_voucher",
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else if (User.getGuard() == "manager") {
        axios.get("/api/fetch_access/" + User.getUserName()).then((res) => {
          if (User.getUserName() != res.data.manager_name) {
            vm.$router.push({ name: "manager_dashboard" });
          }
        });
      } else {
        vm.$router.push({ name: "all_voucher" });
      }
    });
  },
  data() {
    return {
      cost: 0,
      receipt_vouchers: [],
      sorting: false,
      searchTerm: "",
      isAdmin: false,
      isManager: false,
      selectedProject: "",
      projects: [],
      isBuilding: false,
      selectedBuilding: "",
      buildings: [],
      list_style: true,
      client_search: "",
    };
  },

  methods: {
    listDisplay() {
      this.list_style = false;
    },
    removeList() {
      this.list_style = true;
    },
    assignToSearch(item) {
      this.client_search = item;
      this.list_style = true;
    },
    searchByAll() {
      if (User.getGuard() == "admin") {
        const info = {
          client_name: this.client_search,
          project: this.selectedProject,
          building: this.selectedBuilding,
          startDate: this.startDate,
          endDate: this.endDate,
        };
        axios
          .post("/api/receiptBaseSearchExpense", info, {
            headers: {
              "Content-Type": "application/json",
              Accept: "application/json",
            },
          })
          .then((res) => {
            this.receipt_vouchers = res.data;
          })
          .catch((err) => {
            console.log(err.response);
          });
      } else {
        axios
          .get("/api/receiptBaseSearchExpenseManager/" + this.client_search)
          .then((res) => {
            this.receipt_vouchers = res.data;
          })
          .catch((err) => {
            console.log(err.response);
          });
      }
    },
    passDate() {
      const requestData = {
        startDate: this.startDate,
        endDate: this.endDate,
        selectedProject: this.selectedProject,
        selectedBuilding: this.selectedBuilding,
      };
      axios
        .post("/api/fetchReceiptVoucherByDate", requestData, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.receipt_vouchers = res.data;
          this.cost = 0;
          this.receipt_vouchers.forEach((item) => {
            cost += parseInt(item.total_amount);
          });
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    sorting_asc() {
      this.sorting = !this.sorting;
      if (this.sorting == true) {
        return this.receipt_vouchers.sort((a, b) => {
          const nameA = a.financialYear.toUpperCase();
          const nameB = b.financialYear.toUpperCase();
          if (nameA < nameB) {
            return -1;
          }
          if (nameA > nameB) {
            return 1;
          }
          return 0;
        });
      } else {
        return this.receipt_vouchers.sort((a, b) => {
          const nameA = a.financialYear.toUpperCase();
          const nameB = b.financialYear.toUpperCase();
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
    fetchReceiptVouchers() {
      if (User.getGuard() == "admin") {
        this.isAdmin = true;
        this.isManager = false;
        axios
          .get("/api/receipt_voucher")
          .then((res) => {
            this.receipt_vouchers = res.data;
            this.cost = 0;
            this.receipt_vouchers.forEach((item) => {
              this.cost += parseInt(item.total_amount);
            });
          })
          .catch((err) => {
            console.log(err.response);
          });
      } else if (User.getGuard() == "manager") {
        this.isAdmin = false;
        this.isManager = true;
        axios.get("/api/fethProjectPurchaseManager/" + User.getUserName()).then((res) => {
          this.projects = res.data;
          console.log(this.projects);
        });
        //start
        const promises = [];
        axios
          .get("/api/getManagerProject/" + User.getUserName())
          .then((res) => {
            res.data.forEach((item) => {
              promises.push(
                axios.get("/api/getReceiptvouchers/" + item.project).then((res) => {
                  return res.data;
                })
              );
            });

            Promise.all(promises).then((res) => {
              this.receipt_vouchers = res.flat();
              this.cost = 0;
              this.receipt_vouchers.forEach((item) => {
                this.cost += parseInt(item.total_amount);
              });
            });
          })
          .catch((err) => {
            console.log(err.response);
          });

        //end
      }
    },
    deleteVoucher(id) {
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
            .delete("/api/receipt_voucher/" + id)
            .then((res) => {
              //reload the page
              this.receipt_vouchers = this.receipt_vouchers.filter((item) => {
                return item.receipt_id != id;
              });
              this.cost = 0;
              this.receipt_vouchers.forEach((item) => {
                this.cost += parseInt(item.total_amount);
              });
            })
            .catch((err) => {
              console.log(err.response);
            });

          Swal.fire("Deleted!", "Your file has been deleted.", "success");
        }
      });
    },
  },

  created() {
    this.fetchReceiptVouchers();
    if (!User.hasLoggedIn()) {
      this.$router.push({ name: "home" });
    } else {
      this.$router.push({ name: "all_voucher" });
    }
    if (User.getGuard() == "admin") {
      this.isAdmin = true;
      axios
        .get("/api/fetchFilterProject")
        .then((res) => {
          this.projects = res.data;
          console.log(res.data);
        })
        .catch((err) => {
          console.log(err.response);
        });
    }
  },
  computed: {
    filterSearch() {
      const voucher = this.receipt_vouchers.filter((item) => {
        const search = this.client_search.toLowerCase();
        const item_name = item.client_name.toLowerCase();
        return item_name.match(search);
      });
      this.cost = 0;
      voucher.forEach((item) => {
        this.cost += parseInt(item.total_amount);
      });

      return voucher;
    },
    chooseProject() {
      this.isBuilding = true;
      axios
        .get("/api/fetchSelectedProject/" + this.selectedProject)
        .then((res) => {
          this.receipt_vouchers = res.data;
          this.cost = 0;
          this.receipt_vouchers.forEach((item) => {
            this.cost += parseInt(item.total_amount);
          });
          axios
            .get("/api/fetchBuildingInventory/" + this.form.selectedProject)
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
        .get("/api/fetchSelectedBuilding/" + this.selectedBuilding)
        .then((res) => {
          this.receipt_vouchers = res.data;
          this.cost = 0;
          this.receipt_vouchers.forEach((item) => {
            this.cost += parseInt(item.total_amount);
          });
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

table {
  font-size: 0.9em;
}
th {
  font-weight: bold;
  color: #473b5edb;
}

table tr:nth-child(even) {
  background-color: #605ca8 !important;
  color: white;
}

table tr:nth-child(even) .action_td {
  background: #a9abbf;
}

.action {
  color: white;
  background: #3d388d;
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
  color: #228b08 !important;
}

.page_to_page {
  margin-bottom: 1rem;
}

.header_table {
  border-bottom: 1px solid #605ca8;
}

.header_table th {
  font-size: 1rem;
}

.fa-edit {
  color: #002bff;
  font-size: 1.2em;
}

.fa-eye {
  color: green;
  font-size: 1.2em;
}

th {
  font-size: 1.2em;
}
</style>
