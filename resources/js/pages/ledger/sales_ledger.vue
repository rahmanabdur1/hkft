<template>
  <div>
    <h2 class="hkf_title text-center mb-4">Sales Ledger</h2>
    <div>
      <nav>
        <ol class="nav ledger_nav_inline">
          <li class="nav-item ledger_li_inline">
            <router-link class="ledger_link" :to="{ name: 'purchase_ledger' }"
              >Purchase Ledger</router-link
            >
          </li>
          <li class="nav-item ledger_li_inline">
            <router-link class="ledger_link" :to="{ name: 'sales_ledger' }"
              >Sales Ledger</router-link
            >
          </li>
          <li class="nav-item ledger_li_inline">
            <router-link class="ledger_link" :to="{ name: 'apledger' }"
              >Accounts Payable Ledger</router-link
            >
          </li>
          <li class="nav-item ledger_li_inline">
            <router-link class="ledger_link" :to="{ name: 'rpledger' }"
              >Accounts Receivable Ledger</router-link
            >
          </li>
          <li class="nav-item ledger_li_inline">
            <router-link class="ledger_link" :to="{ name: 'cash_ledger' }"
              >Cash Ledger</router-link
            >
          </li>

          <li class="nav-item ledger_li_inline">
            <router-link class="ledger_link" :to="{ name: 'bank_ledger' }">
              Bank Ledger</router-link
            >
          </li>
        </ol>
      </nav>
    </div>
    <button
      type="button"
      class="btn action_print"
      style="margin-left: 85%"
      @click="printContent"
    >
      Print<i class="fa fa-print pl-2" aria-hidden="true"></i>
    </button>
    <div>
      <form @submit.prevent="passLedger()" class="mt-5">
        <div class="form-row">
          <div class="form-group mx-sm-3 mb-2">
            <label class="hkf_text">Product Name:</label>
            <input
              type="text"
              class="form-control"
              placeholder="Product name"
              v-model="product_search"
              @keyup="listDisplay"
            />
            <ul class="ulShow" :class="{ listStyle: list_style }">
              <li
                class="listShow"
                :class="{ listStyle: list_style }"
                v-for="(item, index) in filterProduct"
                :key="index"
                :value="item.product_name"
                @click="assignToSearch(item)"
              >
                {{ item.product_name }}
              </li>
            </ul>
          </div>
          <div class="form-group mx-sm-3 mb-2">
            <label class="hkf_text">Client Name:</label>
            <input
              type="text"
              class="form-control"
              placeholder="Client name"
              v-model="supplier_search"
              @keyup="ReferenceList"
            />
            <ul class="ulShow" :class="{ listStyle: reference_list_style }">
              <li
                class="listShow"
                :class="{ listStyle: reference_list_style }"
                v-for="(item, index) in filterSupplier"
                :key="index"
                :value="item.client_name"
                @click="assignToSearch2(item)"
              >
                {{ item.client_name }}
              </li>
            </ul>
          </div>
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
      <div id="print-container">
        <div style="display: flex">
          <div class="sidebar-brand-icon" style="text-align: left; width: 20%">
            <img
              class="logo"
              :src="'../img/' + avatar"
              style="width: 165%; height: 77%"
              alt=""
            />
          </div>
          <div style="padding: 5%; width: 80%">
            <h3 style="text-align: center">HKF Real Estate LTD</h3>
            <h4 style="text-align: center">
              117/2/8 1st Floor Sopnodanga Residential Area<br />
              Phone: 01400407270 <br />
              Email:contact@hkf-re.com <br />
              Website: www.hkf-re.com
            </h4>
          </div>
        </div>
        <label class="hkf_text"> Date: {{ startDate }} - {{ endDate }} </label>
        <label class="hkf_text"> Property: {{ selectedLedger }} </label>

        <div class="row">
          <div class="form-group mx-sm-3 mb-2"></div>
          <div class="input-group col-md-6"></div>
        </div>
        <table
          class="table custom_table"
          style="width: 100%; border: 1px solid black; border-collapse: collapse"
        >
          <thead class="thead" style="height: 70px">
            <tr>
              <th
                scope="col"
                style="
                  border: 1px solid black;
                  border-collapse: collapse;
                  text-align: center;
                "
              >
                Date
              </th>
              <th
                scope="col"
                style="
                  border: 1px solid black;
                  border-collapse: collapse;
                  text-align: center;
                "
              >
                Particular
              </th>

              <th
                scope="col"
                style="
                  border: 1px solid black;
                  border-collapse: collapse;
                  text-align: center;
                "
              >
                Debit(TK)
              </th>
              <th
                scope="col"
                style="
                  border: 1px solid black;
                  border-collapse: collapse;
                  text-align: center;
                "
              >
                Credit(TK)
              </th>
              <th
                scope="col"
                style="
                  border: 1px solid black;
                  border-collapse: collapse;
                  text-align: center;
                "
              >
                Balance
              </th>
            </tr>
          </thead>

          <tbody>
            <tr v-for="(purchase_ledger, index) in purchase_ledgers" :key='index'>
              <td
                scope="row"
                style="
                  border: 1px solid black;
                  border-collapse: collapse;
                  text-align: center;
                "
              >
                {{ purchase_ledger.date }}
              </td>
              <td
                style="
                  border: 1px solid black;
                  border-collapse: collapse;
                  text-align: center;
                "
              >
                {{ purchase_ledger.supplier_name }}
              </td>

              <td
                style="
                  border: 1px solid black;
                  border-collapse: collapse;
                  text-align: center;
                "
              ></td>
              <td
                style="
                  border: 1px solid black;
                  border-collapse: collapse;
                  text-align: center;
                "
                v-if="purchase_ledger.return_amount == 0"
              >
                {{ Math.abs(purchase_ledger.total_balance) }}
              </td>
              <td
                style="
                  border: 1px solid black;
                  border-collapse: collapse;
                  text-align: center;
                "
                v-if="purchase_ledger.return_amount != 0 && purchase_ledger.paid == 0"
              >
                {{ purchase_ledger.return_amount }}
              </td>
              <td
                style="
                  border: 1px solid black;
                  border-collapse: collapse;
                  text-align: center;
                "
              >
                {{ purchase_ledger.balance }}
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    <!-- <h6 style='color:black;font-weight:bold;text-align:right;width:88%;'>Balance = {{this.sumOfBalance[i]}}</h6> -->
  </div>
</template>

<script>
export default {
  name: "purchase_ledger",

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
        vm.$router.push({ name: "sales_ledger" });
      }
    });
  },
  data() {
    return {
      purchase_ledgers: [],
      selectedLedger: "",
      allLedgers: [],
      startDate: "",
      endDate: "",
      selectedSupplier: "",
      allSuppliers: [],
      avatar: "logo.png",
      list_style: true,
      reference_list_style: true,
      supplier_search: "",
      product_search: "",
    };
  },
  created() {
    axios.get("/api/sales_suppliers").then((res) => {
      this.allSuppliers = res.data;
    });
    axios
      .get("/api/sales_ledger")
      .then((res) => {
        this.allLedgers = res.data;
      })
      .catch((err) => {});
  },
  computed: {
    filterProduct() {
      return this.allLedgers.filter((product) => {
        let product_name = this.product_search.toUpperCase();
        let productLedger = product.product_name.toUpperCase();
        return productLedger.match(product_name);
      });
    },
    filterSupplier() {
      return this.allSuppliers.filter((product) => {
        let supplier_name = this.supplier_search.toUpperCase();
        let supplierLedger = product.client_name.toUpperCase();
        return supplierLedger.match(supplier_name);
      });
    },
  },
  methods: {
    listDisplay() {
      this.list_style = false;
    },
    ReferenceList() {
      this.reference_list_style = false;
    },
    assignToSearch(item) {
      this.product_search = item.product_name;

      this.list_style = true;
      this.selectedLedger = item.product_name;
    },
    assignToSearch2(item) {
      this.supplier_search = item.client_name;

      this.reference_list_style = true;
      this.selectedSupplier = item.client_name;
    },
    passLedger() {
      const requestData = {
        product_name: this.selectedLedger,
        startDate: this.startDate,
        endDate: this.endDate,
        client_name: this.selectedSupplier,
      };
      axios
        .post("/api/sales_ledger/pass_ldg", requestData, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.purchase_ledgers = res.data;
        })
        .catch((err) => {});
    },
    printContent() {
      const printContents = document.getElementById("print-container").innerHTML;
      const originalContents = document.body.innerHTML;
      const popupWin = window.open("width=800,height=800");
      popupWin.document.open();
      popupWin.document.write(`
        <html>
          <head>
            <style>
              /* Your styles go here */
              *{
                padding:0.25rem;

              }
              .custom_table,thead,th,tr,td{
                border:1px solid black;
              }

            </style>
          </head>
          <body onload="window.print();window.close();">${printContents}</body>
        </html>
      `);
      popupWin.document.close();
      this.$router.push({
        name: "sales_ledger",
      });
    },
  },
};
</script>

<style>
.ledger_nav_inline {
  display: inline;
}
.ledger_li_inline {
  display: inline-block;
  text-decoration: underline;
  font-size: 1em;
  margin: 1em;
}
.custom_table tr:nth-child(even) {
  background-color: white !important;
  color: black;
  font-weight: bold;
}
.custom_table tr:nth-child(odd) {
  color: black;
  font-weight: bold;
}
.custom_table th {
  border: 1px solid black;
}

@media only screen and (min-width: 601px) and (max-width: 979px) {
  .margin_remover {
    margin-left: 0%;
    width: 80%;
  }
  .custom_table th {
    font-size: 0.9em;
  }
  .custom_table td {
    font-size: 0.8em;
  }
}

@media only screen and (min-width: 980px) {
  .margin_remover {
    margin-left: 10%;
  }
  .custom_table th {
    font-size: 1em;
  }
  .custom_table td {
    font-size: 1em;
  }
}
@media only screen and (max-width: 600px) {
  .custom_table th {
    font-size: 0.8em;
  }
  .custom_table td {
    font-size: 0.8em;
  }
}
</style>
