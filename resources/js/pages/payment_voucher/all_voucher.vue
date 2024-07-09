<template>
  <div>
    <h2 class="hkf_title text-center mb-4">All Puchased Voucher</h2>
    <div class="row">
      <div class="col-md-6 page_to_page">
        <router-link :to="{ name: 'payment_voucher' }" class="btn btn-primary"
          >Create Purchase Voucher</router-link
        >
      </div>

      <div class="input-group col-md-6" style="display: block">
        <div style="display: flex">
          <input
            type="text"
            class="form-control status"
            placeholder="Supplier Name"
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
              :value="item.payee_name"
              @click="assignToSearch(item.payee_name)"
            >
              {{ item.payee_name }}
            </li>
          </ul>
        </div>
      </div>

      <div class="col-md-4 mb-2">
        <label for="projectName" class="hkf_text">Search Type</label>
        <select
          class="form-control"
          id="status"
          name="status"
          @change="selectedSearch"
          v-model="selectedSearchType"
          required
        >
          <option
            v-for="(search_type, index) in search_types"
            :key="index"
            :value="search_type.value"
          >
            {{ search_type.label }}
          </option>
        </select>
      </div>
      <div class="form-group col-md-4 mx-sm-3 mb-2" v-if="isAdmin && isProject">
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
      <div class="form-group col-md-4 mx-sm-3 mb-2" v-if="isManager && isProject">
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
      <div class="form-group col-md-4 mx-sm-3 mb-2" v-if="isProdcut">
        <label for="projectName" class="hkf_text">Select Product</label>
        <select
          class="form-control status"
          id="status"
          v-model="selectedProduct"
          onfocus="this.size=10"
          onblur="this.size=1"
          onchange="this.size=1;this.blur();"
          @change="chooseProduct"
          required
        >
          <option
            v-for="(project, index) in payment_products"
            :key="index"
            :value="project.product_name"
          >
            {{ project.product_name }}
          </option>
        </select>
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
        <tr class="header_table">
          <th>SL <i class="fa fa-sort" @click="sorting_asc"></i></th>
          <th>Date</th>
          <th>FS Year</th>
          <th>Voucher No</th>
          <th>Supplier's Name</th>
          <th>Project Name</th>
          <th>Building Name</th>
          <th>Product Name</th>
          <th>Product Amount</th>
          <th>Paid</th>
          <th>Due</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(payment, index) in filterSearch" :key="index">
          <td>{{ index + 1 }}</td>
          <td>{{ payment.basic_date }}</td>
          <td>{{ payment.financialYear }}</td>
          <td>
            {{ payment.payment_id }}
          </td>
          <td>
            {{ payment.payee_name }}
          </td>
          <td>
            {{ payment.selectedProject }}
          </td>
          <td>
            {{ payment.building_name }}
          </td>
          <td>
            {{ payment.product_name }}
          </td>
          <td>
            {{ payment.total_amount }}
          </td>
          <td>
            {{ payment.receive_amount }}
          </td>
          <td>
            {{ payment.payment_due }}
          </td>
          <td class="action_td">
            <router-link
              class="btn"
              :to="{ name: 'payment_edit_voucher', params: { id: payment.id } }"
              ><i class="fas fa-edit"></i
            ></router-link>
            <router-link
              class="btn"
              :to="{ name: 'payment_view_voucher', params: { id: payment.id } }"
              ><i class="fa fa-eye"></i
            ></router-link>
            <router-link
              class="btn"
              :to="{ name: 'payment_print_voucher', params: { id: payment.id } }"
              ><i class="fa fa-print"></i
            ></router-link>
            <button class="btn" @click="deleteVoucher(payment.payment_id)">
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
  name: "payment_all_voucher",
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else {
        vm.$router.push({ name: "payment_all_voucher" });
      }
    });
  },
  data() {
    return {
      isBuilding: false,
      buildings: [],
      payment_vouchers: [],
      sorting: false,
      searchTerm: "",
      cost: 0,
      selectedSearchType: "",
      selectedBuilding: "",
      isProject: true,
      isProdcut: true,
      search_types: [
        { label: "Land", value: "Land" },
        { label: "Others", value: "Others" },
      ],
      isAdmin: false,
      isManager: false,
      search_name: "",
      searchLand: false,
      selectedProject: "",
      projects: [],
      selectedProduct: "",
      payment_products: [],
      list_style: true,
      client_search: "",
      startDate: "",
      endDate: "",
      searchLists: false,
    };
  },

  methods: {
    assignToSearch(item) {
      this.client_search = item;
      this.list_style = true;
    },
    searchByAll() {
      if (User.getGuard() == "admin") {
        if (!this.searchLand) {
          const info = {
            client_name: this.client_search,
            project: this.selectedProject,
            building: this.selectedBuilding,
            startDate: this.startDate,
            endDate: this.endDate,
          };
          axios
            .post("/api/paymentBaseSearchExpense", info, {
              headers: {
                "Content-Type": "application/json",
                Accept: "application/json",
              },
            })
            .then((res) => {
              this.payment_vouchers = res.data;
            })
            .catch((err) => {
              console.log(err.response);
            });
        } else {
          const info = {
            client_name: this.client_search,
            project: this.selectedProject,
            building: this.selectedBuilding,
            startDate: this.startDate,
            endDate: this.endDate,
          };
          axios
            .post("/api/paymentBaseSearchExpenseLedger", info, {
              headers: {
                "Content-Type": "application/json",
                Accept: "application/json",
              },
            })
            .then((res) => {
              console.log("ledger");
              console.log(res.data);
              this.payment_vouchers = res.data;
            })
            .catch((err) => {
              console.log(err.response);
            });
        }
      } else {
        if (!this.searchLand) {
          const info = {
            client_name: this.client_search,
            project: this.selectedProject,
            building: this.selectedBuilding,
            startDate: this.startDate,
            endDate: this.endDate,
          };
          axios
            .post("/api/paymentBaseSearchExpenseManager", info, {
              headers: {
                "Content-Type": "application/json",
                Accept: "application/json",
              },
            })
            .then((res) => {
              this.payment_vouchers = res.data;
              console.log(res.data);
            })
            .catch((err) => {
              console.log(err.response);
            });
        } else {
          const info = {
            client_name: this.client_search,
            project: this.selectedProject,
            building: this.selectedBuilding,
            startDate: this.startDate,
            endDate: this.endDate,
          };
          axios
            .post("/api/paymentBaseSearchExpenseManagerLedger", info, {
              headers: {
                "Content-Type": "application/json",
                Accept: "application/json",
              },
            })
            .then((res) => {
              this.payment_vouchers = res.data;
              console.log(res.data);
            })
            .catch((err) => {
              console.log(err.response);
            });
        }
      }
    },
    passDate() {
      const requestData = {
        startDate: this.startDate,
        endDate: this.endDate,
        selectedProject: this.selectedProject,
        selectedBuilding: this.selectedBuilding,
        selectedProduct: this.selectedProduct,
      };
      axios
        .post("/api/fetchPaymentVoucherByDate", requestData, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.payment_vouchers = res.data;
          console.log(res.data);
          this.cost = 0;
          this.payment_vouchers.forEach((item) => {
            cost += parseInt(item.receive_amount);
          });
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    sorting_asc() {
      this.sorting = !this.sorting;
      if (this.sorting == true) {
        return this.payment_vouchers.sort((a, b) => {
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
        return this.payment_vouchers.sort((a, b) => {
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
        axios
          .get("/api/payment_voucher")
          .then((res) => {
            this.payment_vouchers = res.data;
            this.cost = 0;
            this.payment_vouchers.forEach((item) => {
              this.cost += parseInt(item.receive_amount);
            });
          })
          .catch((err) => {});

        axios.get("/api/fethProjectPurchase").then((res) => {
          this.projects = res.data;
          console.log(this.projects);
        });
      } else if (User.getGuard() == "manager") {
        axios.get("/api/fethProjectPurchaseManager/" + User.getUserName()).then((res) => {
          this.projects = res.data;
          console.log(this.projects);
        });
        const promises = [];
        axios
          .get("/api/getManagerProject/" + User.getUserName())
          .then((res) => {
            res.data.forEach((item) => {
              promises.push(
                axios.get("/api/getPaymentvouchers/" + item.project).then((res) => {
                  return res.data;
                })
              );
            });

            Promise.all(promises).then((res) => {
              this.payment_vouchers = res.flat();
              this.cost = 0;
              this.payment_vouchers.forEach((item) => {
                this.cost += parseInt(item.receive_amount);
              });
            });
          })
          .catch((err) => {});
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
            .delete("/api/payment_voucher/" + id)
            .then((res) => {
              this.payment_vouchers = this.payment_vouchers.filter((item) => {
                return item.payment_id != id;
              });
              this.cost = 0;
              this.payment_vouchers.forEach((item) => {
                this.cost += parseInt(item.receive_amount);
              });
            })
            .catch((err) => {});

          Swal.fire("Deleted!", "Your file has been deleted.", "success");
        }
      });
    },
  },

  created() {
    this.fetchReceiptVouchers();
    if (User.getGuard() == "admin") {
      this.isAdmin = true;
      this.isManager = false;
    } else {
      this.isAdmin = false;
      this.isManager = true;
    }
  },
  computed: {
    listDisplay() {
      this.list_style = false;
      this.searchLists = true;
    },
    removeList() {
      this.list_style = true;
    },
    selectedSearch() {
      if (this.selectedSearchType == "Land") {
        this.searchLand = true;
        this.isProject = false;
        this.isProdcut = false;
        this.list_style = true;
      } else {
        this.searchLand = false;
        this.isProject = true;
        this.isProdcut = true;
      }
    },
    chooseProduct() {
      axios
        .get("/api/getDataByProduct/" + this.selectedProduct)
        .then((res) => {
          this.payment_vouchers = res.data;
          this.cost = 0;
          this.payment_vouchers.forEach((item) => {
            this.cost += parseInt(item.receive_amount);
          });
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    filterSearch() {
      const voucher = this.payment_vouchers.filter((item) => {
        const search = this.client_search.toLowerCase();

        if (!this.searchLand) {
          const item_name = item.payee_name.toLowerCase();
          return item_name.match(search);
        } else if (this.searchLand) {
          const item_name3 = item.ledger_no;

          return item_name3.includes(search);
        }
      });
      this.cost = 0;
      voucher.forEach((item) => {
        this.cost += parseInt(item.receive_amount);
      });

      return voucher;
    },
    chooseBuilding() {
      this.isProdcut = true;
      axios
        .get("/api/getPurchaseByBuilding/" + this.selectedBuilding)
        .then((res) => {
          this.payment_vouchers = res.data;
          this.cost = 0;
          this.payment_vouchers.forEach((item) => {
            this.cost += parseInt(item.receive_amount);
          });
        })
        .catch((err) => {
          console.log(err.response);
        });
      axios
        .get("/api/getProductByBuilding/" + this.selectedBuilding)
        .then((res) => {
          this.payment_products = res.data;
          this.cost = 0;
          this.payment_vouchers.forEach((item) => {
            this.cost += parseInt(item.receive_amount);
          });
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    chooseProject() {
      this.isProdcut = true;
      axios
        .get("/api/fetchSingleProjectPurchase/" + this.selectedProject)
        .then((res) => {
          this.payment_vouchers = res.data;
          console.log(res.data);
          this.cost = 0;
          this.payment_vouchers.forEach((item) => {
            this.cost += parseInt(item.receive_amount);
          });
        })
        .catch((err) => {
          console.log(err.response);
        });
      axios
        .get("/api/getProductByProject/" + this.selectedProject)
        .then((res) => {
          this.payment_products = res.data;
          console.log(res.data);
        })
        .catch((err) => {
          console.log(err.response);
        });
      this.isBuilding = true;
      axios
        .get("/api/fetchSelectedProject/" + this.selectedProject)
        .then((res) => {
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
  },
};
</script>
<style>
table {
  text-align: center;
}
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
  color: #66a756 !important;
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
.fa-trash {
  color: #d33a3a;
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
