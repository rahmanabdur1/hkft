<template>
  <div>
    <!-- Begin Page Content -->
    <div class="container-fluid">
      <!-- Page Heading -->
      <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h2 class="hkf_text text-center mb-4" style="font-weight: 400">Dashboard</h2>
        <div style="display: block">
          <div>
            <ul>
              <li class="listAlign">
                <button type="button" class="listBtn" @click="dailyAccounts">
                  Daily
                </button>
              </li>
              <li class="listAlign">
                <button type="button" class="listBtn" @click="weeklyAccounts">
                  Weekly
                </button>
              </li>
              <li class="listAlign">
                <button type="button" class="listBtn" @click="monthlyAccounts">
                  Monthly
                </button>
              </li>
              <li class="listAlign">
                <button type="button" class="listBtn" @click="yearlyAccounts">
                  Yearly
                </button>
              </li>
            </ul>
          </div>
        </div>
      </div>
      <div>
        <form @submit.prevent="dateAccounts" class="col-md-12">
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
      <div class="row">
        <div class="form-group col-md-4 mx-sm-3 mb-2">
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
        <div class="form-group col-md-4 mx-sm-3 mb-2">
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
      <!-- Content Row -->
      <div class="row">
        <!-- Earnings (Monthly) Card Example -->
        <div class="col-xl-3 col-md-6 mb-4">
          <div class="card border-left-primary shadow h-100 py-2">
            <div class="card-body">
              <div class="row no-gutters align-items-center">
                <div class="col mr-2">
                  <div class="font-weight-bold text-primary text-uppercase mb-1">
                    Purchase Amount
                  </div>
                  <div class="h5 mb-0 font-weight-bold text-gray-800">
                    {{ purchaseAmount }} tk
                  </div>
                </div>
                <div class="col-auto">
                  <i class="fas fa-calendar fa-2x text-gray-300"></i>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Earnings (Monthly) Card Example -->
        <div class="col-xl-3 col-md-6 mb-4">
          <div class="card border-left-success shadow h-100 py-2">
            <div class="card-body">
              <div class="row no-gutters align-items-center">
                <div class="col mr-2">
                  <div class="font-weight-bold text-success text-uppercase mb-1">
                    Sales Amount
                  </div>
                  <div class="h5 mb-0 font-weight-bold text-gray-800">
                    {{ salesAmount }} tk
                  </div>
                </div>
                <div class="col-auto">
                  <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Earnings (Monthly) Card Example -->
        <div class="col-xl-3 col-md-6 mb-4">
          <div class="card border-left-info shadow h-100 py-2">
            <div class="card-body">
              <div class="row no-gutters align-items-center">
                <div class="col mr-2">
                  <div class="font-weight-bold text-info text-uppercase mb-1">
                    Payment Due
                  </div>
                  <div class="row no-gutters align-items-center">
                    <div class="col-auto">
                      <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">
                        {{ paymentDue }} tk
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-auto">
                  <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Pending Requests Card Example -->
        <div class="col-xl-3 col-md-6 mb-4">
          <div class="card border-left-warning shadow h-100 py-2">
            <div class="card-body">
              <div class="row no-gutters align-items-center">
                <div class="col mr-2">
                  <div class="font-weight-bold text-danger text-uppercase mb-1">
                    Receipt Due
                  </div>
                  <div class="h5 mb-0 font-weight-bold text-gray-800">
                    {{ receiptDue }} tk
                  </div>
                </div>
                <div class="col-auto">
                  <i class="fas fa-comments fa-2x text-gray-300"></i>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-4">
          <div class="card border-left-secondary shadow h-100 py-2">
            <div class="card-body">
              <div class="row no-gutters align-items-center">
                <div class="col mr-2">
                  <div class="font-weight-bold text-secondary text-uppercase mb-1">
                    Expense
                  </div>
                  <div class="h5 mb-0 font-weight-bold text-gray-800">
                    {{ totalExpense }} tk
                  </div>
                </div>
                <div class="col-auto">
                  <i class="fas fa-comments fa-2x text-gray-300"></i>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- Pending Requests Card Example -->
        <div class="col-xl-3 col-md-6 mb-4">
          <div class="card border-left-danger shadow h-100 py-2">
            <div class="card-body">
              <div class="row no-gutters align-items-center">
                <div class="col mr-2">
                  <div class="font-weight-bold text-danger text-uppercase mb-1">
                    Salary
                  </div>
                  <div class="h5 mb-0 font-weight-bold text-gray-800">
                    {{ totalSalary }} tk
                  </div>
                </div>
                <div class="col-auto">
                  <i class="fas fa-comments fa-2x text-gray-300"></i>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-xl-3 col-md-6 mb-4">
          <div class="card shadow h-100 py-2" style="border-left: 5px solid violet">
            <div class="card-body">
              <div class="row no-gutters align-items-center">
                <div class="col mr-2">
                  <div class="font-weight-bold text-uppercase mb-1" style="color: violet">
                    Total Client
                  </div>
                  <div class="h5 mb-0 font-weight-bold text-gray-800">
                    {{ totalClient }}
                  </div>
                </div>
                <div class="col-auto">
                  <i class="fas fa-comments fa-2x text-gray-300"></i>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-4">
          <div class="card shadow h-100 py-2" style="border-left: 5px solid teal">
            <div class="card-body">
              <div class="row no-gutters align-items-center">
                <div class="col mr-2">
                  <div class="font-weight-bold text-uppercase mb-1" style="color: yteal">
                    Total Supplier
                  </div>
                  <div class="h5 mb-0 font-weight-bold text-gray-800">
                    {{ totalSupplier }}
                  </div>
                </div>
                <div class="col-auto">
                  <i class="fas fa-comments fa-2x text-gray-300"></i>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-4">
          <div class="card shadow h-100 py-2" style="border-left: 5px solid maroon">
            <div class="card-body">
              <div class="row no-gutters align-items-center">
                <div class="col mr-2">
                  <div class="font-weight-bold text-uppercase mb-1" style="color: maroon">
                    Total Employee
                  </div>
                  <div class="h5 mb-0 font-weight-bold text-gray-800">
                    {{ totalEmployee }}
                  </div>
                </div>
                <div class="col-auto">
                  <i class="fas fa-comments fa-2x text-gray-300"></i>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- Content Row -->

      <div class="row mt-5 mb-5">
        <!-- Pie Chart -->
        <pie-chart :data="productAndProject"></pie-chart>
        <label for="" class="hkf_text mx-auto" style="font-size: 1.2em !important"
          >Fig: Project Basis Sell Amount (project-sales amount)</label
        >
      </div>

      <div class="row mt-5 mb-5">
        <!-- Pie Chart -->
        <column-chart :data="timeAndProject"></column-chart>
        <label for="" class="hkf_text mx-auto" style="font-size: 1.2em !important"
          >Fig: Time Basis Sales (date-sales amount)</label
        >
        <!-- Area Chart -->
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "manager_dashboard",
  data() {
    return {
      activeGuard: "",
      purchaseAmount: 0,
      salesAmount: 0,
      paymentDue: 0,
      receiptDue: 0,
      totalExpense: 0,
      totalSalary: 0,
      productAndProject: [],
      timeAndProject: {},
      passDate: "",
      selectedProject: "",
      selectedBuilding: "",
      projects: [],
      buildings: [],
      okEndDate: "",
      okStartDate: "",
      totalClient: "",
      totalSupplier: "",
      totalEmployee: "",
    };
  },

  created() {
    this.activeGuard = User.getGuard();
    console.log(User.getGuard());
    if (!User.hasLoggedIn()) {
      this.$router.push({ name: "login_manager" });
    } else if (User.getGuard() == "manager") {
      this.$router.push({ name: "manager_dashboard" });
    } else {
      this.$router.push({ name: "manager_login" });
    }
    axios.get("/api/fethProjectPurchaseManager/" + User.getUserName()).then((res) => {
      this.projects = res.data;
      console.log(this.projects);
    });
    //dashboard
    axios
      .get("/api/getPurchaseAmount")
      .then((res) => {
        this.purchaseAmount = res.data;
      })
      .catch((err) => {
        console.log(err.response);
      });
    axios
      .get("/api/getSalesAmount")
      .then((res) => {
        this.salesAmount = res.data;
      })
      .catch((err) => {});
    axios
      .get("/api/getPaymentDue")
      .then((res) => {
        this.paymentDue = res.data;
      })
      .catch((err) => {});
    axios
      .get("/api/getReceiptDue")
      .then((res) => {
        this.receiptDue = res.data;
      })
      .catch((err) => {});
    axios
      .get("/api/piechart")
      .then((res) => {
        this.productAndProject = res.data;
      })
      .catch((err) => {});
    axios
      .get("/api/areachart")
      .then((res) => {
        this.timeAndProject = res.data;
      })
      .catch((err) => {});
    //client, supplier & employee
    axios
      .get("/api/totalClient")
      .then((res) => {
        this.totalClient = res.data;
        console.log(this.totalClient);
      })
      .catch((err) => {
        console.log(err.response);
      });

    axios
      .get("/api/totalSupplier")
      .then((res) => {
        this.totalSupplier = res.data;
        console.log(this.totalSupplier);
      })
      .catch((err) => {
        console.log(err.response);
      });

    axios
      .get("/api/totalEmployee")
      .then((res) => {
        this.totalEmployee = res.data;
        console.log(this.totalEmployee);
      })
      .catch((err) => {
        console.log(err.response);
      });
  },
  methods: {
    dailyAccounts() {
      axios
        .get("/api/calculateDailyPurchase")
        .then((res) => {
          this.purchaseAmount = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });
      axios
        .get("/api/calculateDailySalesAmount")
        .then((res) => {
          this.salesAmount = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/calculateDailyPaymentDue")
        .then((res) => {
          this.paymentDue = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/calculateDailyReceiptDue")
        .then((res) => {
          this.receiptDue = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });

      //client, supplier & employee
      axios
        .get("/api/totalDailyClient")
        .then((res) => {
          this.totalClient = res.data;
          console.log(this.totalClient);
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/totalDailySupplier")
        .then((res) => {
          this.totalSupplier = res.data;
          console.log(this.totalSupplier);
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/totalDailyEmployee")
        .then((res) => {
          this.totalEmployee = res.data;
          console.log(this.totalEmployee);
        })
        .catch((err) => {
          console.log(err.response);
        });
    },

    weeklyAccounts() {
      axios
        .get("/api/calculateWeeklyPurchase")
        .then((res) => {
          this.purchaseAmount = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });
      axios
        .get("/api/calculateWeeklySalesAmount")
        .then((res) => {
          this.salesAmount = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/calculateWeeklyPaymentDue")
        .then((res) => {
          this.paymentDue = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/calculateWeeklyReceiptDue")
        .then((res) => {
          this.receiptDue = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/totalWeeklyClient")
        .then((res) => {
          this.totalClient = res.data;
          console.log(this.totalClient);
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/totalWeeklySupplier")
        .then((res) => {
          this.totalSupplier = res.data;
          console.log(this.totalSupplier);
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/totalWeeklyEmployee")
        .then((res) => {
          this.totalEmployee = res.data;
          console.log(this.totalEmployee);
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    monthlyAccounts() {
      axios
        .get("/api/calculateMonthlyPurchase")
        .then((res) => {
          this.purchaseAmount = res.data;
          console.log(res.data);
        })
        .catch((err) => {
          console.log(err.response);
        });
      axios
        .get("/api/calculateMonthlySalesAmount")
        .then((res) => {
          this.salesAmount = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/calculateMonthlyPaymentDue")
        .then((res) => {
          this.paymentDue = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/calculateMonthlyReceiptDue")
        .then((res) => {
          this.receiptDue = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/calculateMonthlyGetExpense")
        .then((res) => {
          this.totalExpense = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });
      axios
        .get("/api/calculateMonthlyGetSalary")
        .then((res) => {
          this.totalSalary = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/totalMonthlyClient")
        .then((res) => {
          this.totalClient = res.data;
          console.log(this.totalClient);
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/totalMonthlySupplier")
        .then((res) => {
          this.totalSupplier = res.data;
          console.log(this.totalSupplier);
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/totalMonthlyEmployee")
        .then((res) => {
          this.totalEmployee = res.data;
          console.log(this.totalEmployee);
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    yearlyAccounts() {
      axios
        .get("/api/calculateYearlyPurchase")
        .then((res) => {
          this.purchaseAmount = res.data;
          console.log(res.data);
        })
        .catch((err) => {
          console.log(err.response);
        });
      axios
        .get("/api/calculateYearlySalesAmount")
        .then((res) => {
          this.salesAmount = res.data;

          console.log(res.data);
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/calculateYearlyPaymentDue")
        .then((res) => {
          this.paymentDue = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/calculateYearlyReceiptDue")
        .then((res) => {
          this.receiptDue = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/calculateYearlyGetExpense")
        .then((res) => {
          this.totalExpense = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });
      axios
        .get("/api/calculateYearlyGetSalary")
        .then((res) => {
          this.totalSalary = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/totalYearlyClient")
        .then((res) => {
          this.totalClient = res.data;
          console.log(this.totalClient);
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/totalYearlySupplier")
        .then((res) => {
          this.totalSupplier = res.data;
          console.log(this.totalSupplier);
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/totalYearlyEmployee")
        .then((res) => {
          this.totalEmployee = res.data;
          console.log(this.totalEmployee);
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    dateAccounts() {
      const data = {
        startDate: this.okStartDate,
        endDate: this.okEndDate,
      };
      axios
        .post("/api/calculateDatePurchase", data, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.purchaseAmount = res.data;
          console.log(res.data);
        })
        .catch((err) => {
          console.log(err.response);
        });
      axios
        .post("/api/calculateDateSalesAmount", data, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.salesAmount = res.data;

          console.log(res.data);
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .post("/api/calculateDatePaymentDue", data, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.paymentDue = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .post("/api/calculateDateReceiptDue", data, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.receiptDue = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .post("/api/calculateDateGetExpense", data, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.totalExpense = res.data;
          console.log(res.data);
        })
        .catch((err) => {
          console.log(err.response);
        });
      axios
        .post("/api/calculateDateGetSalary", data, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.totalSalary = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });

      //  axios.post('/api/totalDateClient',data, {
      //       headers: {
      //         "Content-Type": "application/json",
      //         Accept: "application/json",
      //       },
      //     }).then((res)=>{
      //     this.totalClient = res.data;
      //     console.log(this.totalClient);
      // }).catch((err)=>{
      //     console.log(err.response);
      // });

      //  axios.post('/api/totalDateSupplier',data, {
      //       headers: {
      //         "Content-Type": "application/json",
      //         Accept: "application/json",
      //       },
      //     }).then((res)=>{
      //     this.totalSupplier = res.data;
      //     console.log(this.totalSupplier);
      // }).catch((err)=>{
      //     console.log(err.response);
      // });

      axios
        .post("/api/totalDateEmployee", data, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.totalEmployee = res.data;
          console.log(this.totalEmployee);
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
  },
  computed: {
    chooseProject() {
      axios
        .get("/api/fetchBuildingInventory/" + this.selectedProject)
        .then((res) => {
          this.buildings = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });
      axios
        .get("/api/calculateProjectPurchase/" + this.selectedProject)
        .then((res) => {
          this.purchaseAmount = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });
      axios
        .get("/api/calculateProjectSalesAmount/" + this.selectedProject)
        .then((res) => {
          this.salesAmount = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/calculateProjectPaymentDue/" + this.selectedProject)
        .then((res) => {
          this.paymentDue = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/calculateProjectReceiptDue/" + this.selectedProject)
        .then((res) => {
          this.receiptDue = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/calculateProjectGetExpense/" + this.selectedProject)
        .then((res) => {
          this.totalExpense = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/calculateProjectGetSalary/" + this.selectedProject)
        .then((res) => {
          this.totalSalary = res.data;
          console.log(res.data);
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/totalProjectClient/" + this.selectedProject)
        .then((res) => {
          this.totalClient = res.data;
          console.log(this.totalClient);
        })
        .catch((err) => {
          console.log(err.response);
        });

      //  axios.get('/api/totalProjectSupplier/'+this.selectedProject).then((res)=>{
      //     this.totalSupplier = res.data;
      //     console.log(this.totalSupplier);
      // }).catch((err)=>{
      //     console.log(err.response);
      // });

      axios
        .get("/api/totalProjectEmployee/" + this.selectedProject)
        .then((res) => {
          this.totalEmployee = res.data;
          console.log(this.totalEmployee);
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    chooseBuilding() {
      axios
        .get("/api/calculateBuildingPurchase/" + this.selectedBuilding)
        .then((res) => {
          this.purchaseAmount = res.data;
          console.log(res.data);
        })
        .catch((err) => {
          console.log(err.response);
        });
      axios
        .get("/api/calculateBuildingSalesAmount/" + this.selectedBuilding)
        .then((res) => {
          this.salesAmount = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/calculateBuildingPaymentDue/" + this.selectedBuilding)
        .then((res) => {
          this.paymentDue = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/calculateBuildingReceiptDue/" + this.selectedBuilding)
        .then((res) => {
          this.receiptDue = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/calculateBuildingGetExpense/" + this.selectedBuilding)
        .then((res) => {
          this.totalExpense = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/calculateBuildingGetSalary/" + this.selectedBuilding)
        .then((res) => {
          this.totalSalary = res.data;
          console.log(res.data);
        })
        .catch((err) => {
          console.log(err.response);
        });

      axios
        .get("/api/totalBuildingClient/" + this.selectedBuilding)
        .then((res) => {
          this.totalClient = res.data;
          console.log(this.totalClient);
        })
        .catch((err) => {
          console.log(err.response);
        });

      //  axios.get('/api/totalBuildingSupplier/'+this.selectedBuilding).then((res)=>{
      //     this.totalSupplier = res.data;
      //     console.log(this.totalSupplier);
      // }).catch((err)=>{
      //     console.log(err.response);
      // });

      axios
        .get("/api/totalBuildingEmployee/" + this.selectedBuilding)
        .then((res) => {
          this.totalEmployee = res.data;
          console.log(this.totalEmployee);
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
  },
};
</script>
