<template>
  <div>
    <h3 class="hkf_title text-center mb-4">Sales(Building Base)</h3>

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
            <label class="hkf_text">Project Name:</label>
            <input
              type="text"
              class="form-control"
              placeholder="Project name"
              v-model="project_search"
              @keyup="listDisplay"
            />
            <ul class="ulShow" :class="{ listStyle: list_style }">
              <li
                class="listShow"
                :class="{ listStyle: list_style }"
                v-for="(item, index) in filterProduct"
                :key="index"
                :value="item.property_project"
                @click="assignToSearch(item)"
              >
                {{ item.property_project }}
              </li>
            </ul>
          </div>
          <div class="form-group mx-sm-3 mb-2">
            <label class="hkf_text">Building Name:</label>
            <input
              type="text"
              class="form-control"
              placeholder="Building name"
              v-model="supplier_search"
              @keyup="ReferenceList"
            />
            <ul class="ulShow" :class="{ listStyle: reference_list_style }">
              <li
                class="listShow"
                :class="{ listStyle: reference_list_style }"
                v-for="(item, index) in filterSupplier"
                :key="index"
                :value="item.building_name"
                @click="assignToSearch2(item)"
              >
                {{ item.building_name }}
              </li>
            </ul>
          </div>
          <div class="form-group mx-sm-3 mb-2">
            <label class="hkf_text">Flat Name:</label>
            <input
              type="text"
              class="form-control"
              placeholder="Flat name"
              v-model="flat_search"
              @keyup="flatList"
            />
            <ul class="ulShow" :class="{ listStyle: flat_list_style }">
              <li
                class="listShow"
                :class="{ listStyle: flat_list_style }"
                v-for="(item, index) in filterFlat"
                :key="index"
                :value="item.property_name"
                @click="assignToSearch3(item)"
              >
                {{ item.property_name }}
              </li>
            </ul>
          </div>
          <div class="form-group col-md-8" style="margin-top: 30px">
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

        <table
          class="table custom_table"
          style="
            width: 100%;
            border: 1px solid black;
            border-collapse: collapse;
            text-align: center;
          "
        >
          <thead>
            <th>Project</th>
            <th>Building</th>
            <th>Floor Level</th>
            <th>Name</th>
            <th>Amount</th>
            <th>Enter Amount</th>
            <th>Add Money</th>
            <th>Less Money</th>
          </thead>

          <tbody>
            <tr v-for="(inventory, index) in inventories" :key="index">
              <td style="border: 1px solid black">{{ inventory.property_project }}</td>
              <td style="border: 1px solid black">{{ inventory.building_name }}</td>
              <td style="border: 1px solid black">{{ inventory.floor_level }}</td>
              <td style="border: 1px solid black">{{ inventory.property_name }}</td>
              <td style="border: 1px solid black">{{ inventory.property_amount }} tk</td>
              <td style="border: 1px solid black">
                <button
                  class="btn"
                  type="button"
                  data-toggle="modal"
                  @click="enterModal(inventory.id)"
                >
                  <i class="fas fa-edit"></i>
                </button>
              </td>
              <td style="border: 1px solid black">
                <button
                  class="btn"
                  type="button"
                  data-toggle="modal"
                  @click="addModal(inventory.id)"
                >
                  <i class="fas fa-plus" style="color: green"></i
                  ><span v-if="inventory.add_money">({{ inventory.add_money }} tk)</span
                  ><span v-else>(0 tk)</span>
                </button>
              </td>
              <td style="border: 1px solid black">
                <button
                  class="btn"
                  type="button"
                  data-toggle="modal"
                  @click="lessModal(inventory.id)"
                >
                  <i class="fas fa-minus" style="color: red"></i
                  ><span v-if="inventory.less_money">({{ inventory.less_money }} tk)</span
                  ><span v-else>(0 tk)</span>
                </button>
              </td>
            </tr>
          </tbody>
        </table>
        <div
          class="modal fade"
          id="exampleModal"
          tabindex="-1"
          role="dialog"
          aria-labelledby="exampleModalLabel"
          aria-hidden="true"
        >
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title mt-1" id="exampleModalLabel">Amount</h5>
                <button
                  type="button"
                  class="close"
                  data-dismiss="modal"
                  aria-label="Close"
                >
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body d-flex">
                <input
                  type="text"
                  class="col-md-6 mb-5 form-control mr-2"
                  v-model="amount"
                />
                tk
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">
                  Close
                </button>
                <button type="button" class="btn btn-primary" @click="saveEnter(modalId)">
                  Save changes
                </button>
              </div>
            </div>
          </div>
        </div>
        <div
          class="modal fade"
          id="exampleModal1"
          tabindex="-1"
          role="dialog"
          aria-labelledby="exampleModalLabel"
          aria-hidden="true"
        >
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Add Money</h5>
                <button
                  type="button"
                  class="close"
                  data-dismiss="modal"
                  aria-label="Close"
                >
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body d-flex">
                <input type="text" class="col-md-6 form-control mr-2" v-model="amount" />
                tk
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">
                  Close
                </button>
                <button type="button" class="btn btn-primary" @click="saveAdd(modalId)">
                  Save changes
                </button>
              </div>
            </div>
          </div>
        </div>
        <div
          class="modal fade"
          id="exampleModal2"
          tabindex="-1"
          role="dialog"
          aria-labelledby="exampleModalLabel"
          aria-hidden="true"
        >
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Less Money</h5>

                <button
                  type="button"
                  class="close"
                  data-dismiss="modal"
                  aria-label="Close"
                >
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body d-flex">
                <input type="text" class="col-md-6 form-control mr-2" v-model="amount" />
                tk
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">
                  Close
                </button>
                <button type="button" class="btn btn-primary" @click="saveLess(modalId)">
                  Save changes
                </button>
              </div>
            </div>
          </div>
        </div>
        <div
          class="modal fade"
          id="exampleModal3"
          tabindex="-1"
          role="dialog"
          aria-labelledby="exampleModalLabel"
          aria-hidden="true"
        >
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header" style="display: block">
                <button
                  type="button"
                  class="close"
                  data-dismiss="modal"
                  aria-label="Close"
                >
                  <span aria-hidden="true">&times;</span>
                </button>
                <h2 class="modal-title text-center" id="exampleModalLabel">
                  <img
                    class="logo1"
                    :src="'../img/' + warning_avatar"
                    alt=""
                    style="width: 200px; height: auto"
                  />
                </h2>
                <h2 class="modal-title text-center" id="exampleModalLabel">Warning !!</h2>
              </div>
              <div class="modal-body">
                <p style="color: black">
                  * If you edit this data all previous data maybe destroyed for situation
                  all responsibilities in yours. So be carefull before edit this data.
                </p>
                <p style="color: black">
                  *এই ডাটা এডিট করলে আগের তথ্য বা হিসেবে গরমিল হতে পারে। এবং এটির জন্য
                  আপনি সম্পূর্ণভাবে দায়ী থাকবেন।
                </p>
                <p style="color: black">
                  I agree with the statement / আমি উপরের স্টেটমেন্টটিতে সম্মতি জানাচ্ছি।
                </p>
              </div>
              <div class="modal-footer" style="position: relative">
                <input
                  type="checkbox"
                  name=""
                  id=""
                  v-model="isChecked"
                  style="position: absolute; left: 2%"
                />
                <span style="position: absolute; left: 7%">Agree with terms</span>
                <button type="button" class="btn btn-danger" data-dismiss="modal">
                  Close
                </button>
                <button
                  type="button"
                  class="btn btn-primary"
                  @click="enterModal(modalId)"
                >
                  Yes, Edit It
                </button>
              </div>
            </div>
          </div>
        </div>
        <div
          class="modal fade"
          id="exampleModal4"
          tabindex="-1"
          role="dialog"
          aria-labelledby="exampleModalLabel"
          aria-hidden="true"
        >
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header" style="display: block">
                <button
                  type="button"
                  class="close"
                  data-dismiss="modal"
                  aria-label="Close"
                >
                  <span aria-hidden="true">&times;</span>
                </button>
                <h2 class="modal-title text-center" id="exampleModalLabel">
                  <img
                    class="logo1"
                    :src="'../img/' + warning_avatar"
                    alt=""
                    style="width: 200px; height: auto"
                  />
                </h2>
                <h2 class="modal-title text-center" id="exampleModalLabel">Warning !!</h2>
              </div>
              <div class="modal-body">
                <p style="color: black">
                  * If you edit this data all previous data maybe destroyed for situation
                  all responsibilities in yours. So be carefull before edit this data.
                </p>
                <p style="color: black">
                  *এই ডাটা এডিট করলে আগের তথ্য বা হিসেবে গরমিল হতে পারে। এবং এটির জন্য
                  আপনি সম্পূর্ণভাবে দায়ী থাকবেন।
                </p>
                <p style="color: black">
                  I agree with the statement / আমি উপরের স্টেটমেন্টটিতে সম্মতি জানাচ্ছি।
                </p>
              </div>
              <div class="modal-footer" style="position: relative">
                <input
                  type="checkbox"
                  name=""
                  id=""
                  v-model="addChecked"
                  style="position: absolute; left: 2%"
                />
                <span style="position: absolute; left: 7%">Agree with terms</span>
                <button type="button" class="btn btn-danger" data-dismiss="modal">
                  Close
                </button>
                <button type="button" class="btn btn-primary" @click="addModal(modalId)">
                  Yes, Edit It
                </button>
              </div>
            </div>
          </div>
        </div>
        <div
          class="modal fade"
          id="exampleModal5"
          tabindex="-1"
          role="dialog"
          aria-labelledby="exampleModalLabel"
          aria-hidden="true"
        >
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header" style="display: block">
                <button
                  type="button"
                  class="close"
                  data-dismiss="modal"
                  aria-label="Close"
                >
                  <span aria-hidden="true">&times;</span>
                </button>
                <h2 class="modal-title mt-1 text-center" id="exampleModalLabel">
                  <img
                    class="logo1"
                    :src="'../img/' + warning_avatar"
                    alt=""
                    style="width: 200px; height: auto"
                  />
                </h2>
                <h2 class="modal-title text-center" id="exampleModalLabel">Warning !!</h2>
              </div>
              <div class="modal-body">
                <p style="color: black">
                  * If you edit this data all previous data maybe destroyed for situation
                  all responsibilities in yours. So be carefull before edit this data.
                </p>
                <p style="color: black">
                  *এই ডাটা এডিট করলে আগের তথ্য বা হিসেবে গরমিল হতে পারে। এবং এটির জন্য
                  আপনি সম্পূর্ণভাবে দায়ী থাকবেন।
                </p>
                <p style="color: black">
                  I agree with the statement / আমি উপরের স্টেটমেন্টটিতে সম্মতি জানাচ্ছি।
                </p>
              </div>
              <div class="modal-footer" style="position: relative">
                <input
                  type="checkbox"
                  name=""
                  id=""
                  v-model="lessChecked"
                  style="position: absolute; left: 2%"
                />
                <span style="position: absolute; left: 7%">Agree with terms</span>
                <button type="button" class="btn btn-danger" data-dismiss="modal">
                  Close
                </button>
                <button type="button" class="btn btn-primary" @click="lessModal(modalId)">
                  Yes, Edit It
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "sales_project",

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
        vm.$router.push({ name: "sales_project" });
      }
    });
  },
  data() {
    return {
      checkSold: false,
      isChecked: false,
      addChecked: false,
      lessChecked: false,
      temp_id: "",
      inventories: [],
      modalId: "",
      amount: "",
      flat_search: "",
      flats: [],
      flat_list_style: true,
      ap_ledgers: [],
      selectedLedger: "",
      allLedgers: [],
      startDate: "",
      endDate: "",
      selectedSupplier: "",
      allSuppliers: [],
      avatar: "logo.png",
      warning_avatar: "heading.png",
      list_style: true,
      reference_list_style: true,
      supplier_search: "",
      project_search: "",
      allProjects: [],
      allBuildings: [],
    };
  },
  created() {
    axios
      .get("/api/sales/fetchAllProject")
      .then((res) => {
        this.allProjects = res.data;
        console.log(this.allProjects);
      })
      .catch((err) => {
        console.log(err.response);
      });

    axios.get("/api/sales/sales_project").then((res) => {
      this.inventories = res.data;
      console.log(this.inventories);
    });
  },
  computed: {
    filterFlat() {
      return this.flats.filter((product) => {
        let product_name = this.flat_search.toUpperCase();
        let productLedger = product.property_name.toUpperCase();
        return productLedger.match(product_name);
      });
    },
    filterProduct() {
      return this.allProjects.filter((product) => {
        let product_name = this.project_search.toUpperCase();
        let productLedger = product.property_project.toUpperCase();
        return productLedger.match(product_name);
      });
    },
    filterSupplier() {
      return this.allBuildings.filter((product) => {
        let supplier_name = this.supplier_search.toUpperCase();
        let supplierLedger = product.building_name.toUpperCase();
        return supplierLedger.match(supplier_name);
      });
    },
  },
  methods: {
    enterModal(id) {
      this.modalId = id;
      this.amount = "";
      axios
        .get("/api/checkSold/" + id)
        .then((res) => {
          if (res.data.property_status === "Sold") {
            this.checkSold = true;
            if (this.checkSold) {
              if (this.isChecked) {
                $("#exampleModal3").modal("hide");
                $("#exampleModal").modal("toggle");
              } else {
                $("#exampleModal3").modal("toggle");
                $("#exampleModal").modal("hide");
              }
            }
          } else {
            this.checkSold = false;
            $("#exampleModal3").modal("hide");
            $("#exampleModal").modal("toggle");
          }
          console.log(res.data);
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    addModal(id) {
      this.isChecked = false;
      this.lessChecked = false;
      this.modalId = id;
      this.amount = "";
      axios
        .get("/api/checkSold/" + id)
        .then((res) => {
          if (res.data.property_status === "Sold") {
            this.checkSold = true;
            if (this.checkSold) {
              if (this.addChecked) {
                $("#exampleModal4").modal("hide");
                $("#exampleModal1").modal("toggle");
              } else {
                $("#exampleModal1").modal("hide");
                $("#exampleModal4").modal("toggle");
              }
            }
          } else {
            this.checkSold = false;
            $("#exampleModal4").modal("hide");
            $("#exampleModal1").modal("toggle");
          }
          console.log(res.data);
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    lessModal(id) {
      this.isChecked = false;
      this.addChecked = false;
      this.modalId = id;
      this.amount = "";
      axios
        .get("/api/checkSold/" + id)
        .then((res) => {
          if (res.data.property_status === "Sold") {
            this.checkSold = true;
            if (this.checkSold) {
              if (this.lessChecked) {
                $("#exampleModal5").modal("hide");
                $("#exampleModal2").modal("toggle");
              } else {
                $("#exampleModal2").modal("hide");
                $("#exampleModal5").modal("toggle");
              }
            }
          } else {
            this.checkSold = false;
            $("#exampleModal5").modal("hide");
            $("#exampleModal2").modal("toggle");
          }
          console.log(res.data);
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    saveEnter(id) {
      let form = {
        id: id,
        amount: this.amount,
      };
      axios
        .post("/api/sales/modifySales", form)
        .then((res) => {
          this.isChecked = false;
          console.log(res.data);
          location.reload();
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    saveAdd(id) {
      $("#exampleModal1").modal("hide");
      let form = {
        id: id,
        amount: this.amount,
      };
      axios
        .post("/api/sales/addSales", form)
        .then((res) => {
          location.reload();
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    saveLess(id) {
      $("#exampleModal2").modal("hide");

      let form = {
        id: id,
        amount: this.amount,
      };

      axios
        .post("/api/sales/lessSales", form)
        .then((res) => {
          console.log(res.data);
          location.reload();
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    listDisplay() {
      this.list_style = false;
    },
    ReferenceList() {
      this.reference_list_style = false;
    },
    flatList() {
      this.flat_list_style = false;
    },
    assignToSearch(item) {
      this.project_search = item.property_project;
      this.supplier_search = "";
      this.list_style = true;
      this.selectedLedger = item.property_project;
      axios
        .get("/api/sales_fetch_project/" + this.project_search)
        .then((res) => {
          this.inventories = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });
      axios.get("/api/sales_fetch_building/" + this.project_search).then((res) => {
        this.allBuildings = res.data;
        console.log(this.allBuildings);
      });
    },
    assignToSearch2(item) {
      this.supplier_search = item.building_name;
      this.flat_search = "";
      this.reference_list_style = true;
      this.selectedSupplier = item.building_name;
      axios
        .get("/api/sales_fetch_project_building/" + this.supplier_search)
        .then((res) => {
          this.inventories = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });
      axios
        .get("/api/fetch_property/" + this.supplier_search)
        .then((res) => {
          this.flats = res.data;
          console.log(this.flats);
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    assignToSearch3(item) {
      this.flat_search = item.property_name;
      this.flat_list_style = true;
      axios
        .get("/api/sales_fetch_flat_name/" + this.flat_search)
        .then((res) => {
          this.inventories = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    passLedger() {
      const requestData = {
        product_name: this.selectedLedger,
        startDate: this.startDate,
        endDate: this.endDate,
        supplier_name: this.selectedSupplier,
      };

      axios
        .post("/api/cash_ledger/pass_ldg", requestData, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.ap_ledgers = res.data;
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
        name: "sales_project",
      });
    },
  },
};
</script>

<style>
.logo1 {
  width: 300px;
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
.fixHeight {
  height: 120px;
  overflow-y: scroll;
}
select {
  width: 100%;
  height: 100%;
  font-size: 16px;
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
