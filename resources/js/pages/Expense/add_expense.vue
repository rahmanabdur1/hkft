<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">Add Expense</h2>

    <div class="row">
      <div class="col-md-12">
        <form
          class="form"
          @submit.prevent="receiveVoucher()"
          enctype="multipart/form-data"
        >
          <div class="row box_container">
            <div class="col-md-8 mx-auto formBox">
              <div class="form-group mx-sm-3 mb-2">
                <label for="projectName" class="hkf_text">Select Financial Year</label>
                <select
                  class="form-control"
                  id="status"
                  name="status"
                  v-model="form.financialYear"
                  required
                >
                  <option
                    v-for="(range, index) in yearRanges"
                    :value="range"
                    :key="index"
                  >
                    {{ range }}
                  </option>
                </select>
              </div>
              <div class="form-group mx-sm-3 mb-2">
                <label for="projectName" class="hkf_text">Date</label>
                <input
                  type="date"
                  class="form-control"
                  v-model="form.basic_date"
                  required
                />
              </div>
              <div class="form-group mx-sm-3 mb-2" v-if="admin">
                <label for="projectName" class="hkf_text">Select Project</label>
                <select
                  class="form-control status"
                  id="status"
                  v-model="form.selectedProject"
                  @change="chooseProject"
                  required
                >
                  <option
                    v-for="(project, index) in allProjects"
                    :key="index"
                    :value="project.project_name"
                  >
                    {{ project.project_name }}
                  </option>
                </select>
              </div>

              <div class="form-group mx-sm-3 mb-2" v-if="manager">
                <label for="projectName" class="hkf_text">Select Project</label>
                <select
                  class="form-control status"
                  id="status"
                  v-model="form.selectedProject"
                  @change="chooseProject"
                  required
                >
                  <option
                    v-for="(project, index) in allProjects"
                    :key="index"
                    :value="project.project"
                  >
                    {{ project.project }}
                  </option>
                </select>
              </div>
              <div class="form-group mx-sm-3 mb-2">
                <label for="projectName" class="hkf_text">Select Building</label>
                <select
                  class="form-control status"
                  id="status"
                  v-model="form.building_name"
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
              <div class="form-group mx-sm-3 mb-2">
                <label class="hkf_text">Category Name:</label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Category name"
                  v-model="category_name_search"
                  @keyup="listDisplayCategoryName"
                />
                <ul class="ulShow" :class="{ listStyle: list_style_category_name }">
                  <li
                    class="listShow"
                    :class="{ listStyle: list_style_category_name }"
                    v-for="(item, index) in filterCategoryName"
                    :key="index"
                    :value="item.category_name"
                    @click="assignToSearchCategoryName(item)"
                  >
                    {{ item.category_name }}
                  </li>
                </ul>
              </div>
              <div class="form-group mx-sm-3 mb-2">
                <label class="hkf_text">Category ID:</label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Category ID"
                  v-model="category_id_search"
                  @keyup="listDisplayCategoryId"
                />
                <ul class="ulShow" :class="{ listStyle: list_style_category_id }">
                  <li
                    class="listShow"
                    :class="{ listStyle: list_style_category_id }"
                    v-for="(item, index) in filterCategoryId"
                    :key="index"
                    :value="item.category_id"
                    @click="assignToSearchCategoryId(item)"
                  >
                    {{ item.category_id }}
                  </li>
                </ul>
              </div>
              <div class="form-group col-md-8 mx-sm-3 mb-2">
                <label for="projectName" class="hkf_text">Payment Type</label>
                <select
                  class="form-control"
                  id="status"
                  name="status"
                  v-model="form.selectedPaymentType"
                  @change="choosePaymentType"
                  required
                >
                  <option
                    v-for="(payment, index) in payment_types"
                    :key="index"
                    :value="payment.payment_type"
                  >
                    {{ payment.label }}
                  </option>
                </select>
              </div>
              <div class="form-group mx-sm-3 mb-2" v-if="showBankField">
                <label class="hkf_text">Cash/Bank Account</label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Cash/Bank Account"
                  v-model="form.cash_bank_account"
                  required
                />
              </div>
            </div>

            <div class="row formBox col-md-8 mx-auto cashSection" v-if="bankChoose">
              <div class="col-md-8">
                <h4 class="hkf_title" style="border: none">Payment :</h4>
              </div>
              <div class="row additionalPart">
                <div class="col-md-6">
                  <label for="projectName" class="hkf_text">Cheque No.</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="Cheque no"
                    v-model="form.bank_cheque_no"
                    required
                  />
                </div>
                <div class="col-md-6">
                  <label for="projectName" class="hkf_text">Cheque Date</label>
                  <input
                    type="date"
                    class="form-control"
                    placeholder="Enter Cheque Date"
                    v-model="form.bank_cheque_date"
                    required
                  />
                </div>
              </div>

              <div class="row additionalPart">
                <div class="col-md-6">
                  <label class="hkf_text">Issuing Bank Name</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="Enter Issuing Bank Name"
                    v-model="form.bank_name"
                    required
                  />
                </div>
                <div class="col-md-6">
                  <label class="hkf_text">Issuing Branch Name</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="Enter Issuing Branch Name"
                    v-model="form.bank_branch"
                  />
                </div>
              </div>
            </div>

            <div class="row formBox col-md-8 mx-auto cashSection">
              <div class="row additionalPart">
                <div class="col-md-10">
                  <label class="hkf_text">Cost Purpose</label>
                  <input type="text" class="form-control" v-model="form.product_name" />
                </div>
              </div>
              <div class="row additionalPart">
                <div class="col-md-10">
                  <label class="hkf_text">Expense Voucher</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="Expense Voucher"
                    v-model="form.expense_voucher"
                  />
                </div>
              </div>
              <div class="row additionalPart">
                <div class="col-md-10">
                  <label class="hkf_text">Cost Amount</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="Cost Amount"
                    v-model="form.receive_amount"
                  />
                </div>
              </div>
              <div class="row additionalPart">
                <div class="col-md-10">
                  <label class="hkf_text">Note</label>
                  <textarea
                    rows="4"
                    type="text"
                    class="form-control"
                    placeholder="Note..."
                    v-model="form.note"
                  ></textarea>
                </div>
              </div>
              <div class="row additionalPart">
                <div class="col-md-10">
                  <label for="location" class="hkf_text">File</label>
                  <input
                    type="file"
                    class="form-control-file col-md-6"
                    @change="selectedDocs"
                  />

                  <embed :src="Supporting_docs" type="application/pdf" />
                </div>
              </div>
            </div>
          </div>

          <div class="col-md-8 mx-auto" style="text-align: right">
            <button type="submit" class="btn btn-primary mb-2" v-show="showSubmit">
              Save
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "add_account_type",
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else {
        vm.$router.push({ name: "add_expense" });
      }
    });
  },

  data() {
    return {
      admin: false,
      manager: false,
      allProjects: [],
      category_name_search: "",
      category_id_search: "",
      list_style_category_id: true,
      list_style_category_name: true,
      categories: [],
      Supporting_docs: "",
      product_types: [
        { value: "land", label: "Land" },
        { value: "others", label: "Others" },
      ],
      bankChoose: false,
      form: {
        financialYear: "",
        basic_date: "",
        selectedPaymentType: "",
        cash_bank_account: "",
        selectedProject: "",
        product_name: "",
        bank_cheque_no: "",
        bank_cheque_date: "",
        bank_name: "",
        bank_branch: "",
        receive_amount: "",
        payment_id: "",
        building_name: "",
        Supporting_docs: "",
        note: "",
        expense_voucher: "",
        category_name: "",
        category_id: "",
      },
      buildings: [],
      isProject: false,
      isLand: false,
      showSubmit: true,
      allItems: [],
      suppliers: [],
      product_name: "",
      excess_receive: false,
      excess_receive_msg: "Purchased Amount Is Greater Than Product Price",
      showBankField: false,
      payment_types: [
        { payment_type: "Cash", label: "Cash" },
        { payment_type: "Cheque", label: "Cheque" },
      ],
    };
  },
  created() {
    axios
      .get("/api/supplier")
      .then((res) => {
        this.suppliers = res.data;
      })
      .catch((err) => {});

    //admin  & manager
    this.guard = User.getGuard();
    if (this.guard == "admin") {
      this.admin = true;
      this.manager = false;
      axios
        .get("/api/project")
        .then((res) => {
          this.allProjects = res.data;
        })
        .catch((err) => {});
    } else if (this.guard == "manager") {
      this.manager = true;
      this.admin = false;
      this.manager_username = User.getUserName();
      axios
        .get("/api/getManagerProject/" + this.manager_username)
        .then((res) => {
          this.allProjects = res.data;
        })
        .catch((err) => {});
    }
    axios
      .get("/api/category")
      .then((res) => {
        this.categories = res.data;
        console.log(this.categories);
      })
      .catch((err) => {
        console.log(err.response);
      });
    //end
  },
  methods: {
    listDisplayCategoryName() {
      this.list_style_category_name = false;
    },
    listDisplayCategoryId() {
      this.list_style_category_id = false;
    },
    assignToSearchCategoryName(item) {
      this.list_style_category_name = true;
      this.category_name_search = item.category_name;
      this.form.category_name = item.category_name;
      this.form.category_id = item.category_id;
      this.category_id_search = item.category_id;
      this.list_style_category_id = true;
    },
    assignToSearchCategoryId(item) {
      this.list_style_category_id = true;
      this.list_style_category_name = true;
      this.form.category_name = item.category_name;
      this.form.category_id = item.category_id;
      this.category_name_search = item.category_name;
      this.category_id_search = item.category_id;
    },
    receiveVoucher() {
      const alphabet = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz";
      let randomString = "";
      for (let i = 0; i < 5; i++) {
        const randomIndex = Math.floor(Math.random() * alphabet.length);
        const randomLetter = alphabet.charAt(randomIndex);
        randomString += randomLetter;
      }
      const uniqueId = randomString + "-" + Math.floor(Math.random() * 100000);

      this.form.payment_id = uniqueId;
      //payment_account

      //payment_voucher
      const formData = new FormData();
      formData.append("category_name", this.form.category_name);
      formData.append("category_id", this.form.category_id);
      formData.append("selectedProject", this.form.selectedProject);
      formData.append("financialYear", this.form.financialYear);
      formData.append("basic_date", this.form.basic_date);
      formData.append("selectedPaymentType", this.form.selectedPaymentType);
      formData.append("product_name", this.form.product_name);
      formData.append("receive_amount", this.form.receive_amount);
      formData.append("payment_id", this.form.payment_id);
      formData.append("building_name", this.form.building_name);
      formData.append("bank_cheque_no", this.form.bank_cheque_no);
      formData.append("bank_cheque_date", this.form.bank_cheque_date);
      formData.append("bank_name", this.form.bank_name);
      formData.append("bank_branch", this.form.bank_branch);
      formData.append("cash_bank_account", this.form.cash_bank_account);
      formData.append("Supporting_docs", this.form.Supporting_docs);
      formData.append("note", this.form.note);
      formData.append("expense_voucher", this.form.expense_voucher);

      console.log(this.form);
      axios
        .post("/api/expense", formData, {
          headers: {
            "Content-Type": "multipart/form-data",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.$router.push({ name: "all_expense" });
        })
        .catch((err) => {});
    },

    selectedDocs() {
      let file = event.target.files[0];
      let reader = new FileReader();
      reader.onload = (event) => {
        this.Supporting_docs = event.target.result;
        this.form.Supporting_docs = file;
      };

      reader.readAsDataURL(file);
    },
    fullPrice() {
      let qty = parseInt(this.form.qty);
      let pup = parseInt(this.form.per_unit_price);
      this.form.total_amount = pup * qty;
      this.calculateTotal();
    },
  },
  computed: {
    filterCategoryName() {
      return this.categories.filter((product) => {
        let product_name = this.category_name_search.toUpperCase();
        let inventory_name = product.category_name.toUpperCase();
        return inventory_name.match(product_name);
      });
    },
    filterCategoryId() {
      return this.categories.filter((product) => {
        let product_name = this.category_id_search.toUpperCase();
        let inventory_name = product.category_id.toUpperCase();
        return inventory_name.match(product_name);
      });
    },
    filterSearch() {
      return this.suppliers.filter((project) => {
        const search_Term = this.client_search.toLowerCase();
        const typeName = project.supplier_name.toLowerCase();
        return typeName.match(search_Term);
      });
    },
    calculateTotal() {
      let total_amount = parseInt(this.form.total_amount);
      let receive_amount = parseInt(this.form.receive_amount);
      if (receive_amount == total_amount) {
        this.form.payment_due = 0;
        this.excess_receive = false;
        this.showSubmit = true;
      } else if (total_amount > receive_amount) {
        this.form.payment_due = total_amount - receive_amount;
        this.excess_receive = false;
        this.showSubmit = true;
      } else if (total_amount < receive_amount) {
        this.form.payment_due = 0;
        this.excess_receive = true;
        this.showSubmit = false;
      }
    },

    yearRanges() {
      const currentYear = new Date().getFullYear();
      const nextYear = currentYear + 1;
      const yearRanges = [
        `${currentYear - 1}-${currentYear}`,
        `${currentYear}-${nextYear}`,
      ];

      return yearRanges;
    },
    choosePaymentType() {
      if (this.form.selectedPaymentType == "Cash") {
        this.bankChoose = false;
        this.showBankField = false;
      } else if (this.form.selectedPaymentType == "Cheque") {
        this.bankChoose = true;
        this.showBankField = true;
      }
    },
    selectUnit() {
      axios
        .get("/api/unit/" + this.form.product_name)
        .then((res) => {
          this.form.item_unit = res.data.item_unit;
          this.form.item_id = res.data.id;
        })
        .catch((err) => {});
      if (this.form.product_name.toLowerCase() == "land") {
        this.isLand = true;
      } else {
        this.isLand = false;
      }
    },
    choosePayee() {
      this.suppliers.forEach((supplier) => {
        if (supplier.id == this.form.payee_id) {
          this.form.payee_name = supplier.supplier_name;
        }
      });
    },
    chooseProductType() {
      if (this.form.product_type.toLowerCase() == "land") {
        this.isProject = false;
        axios
          .get("/api/filterUnit/" + this.form.product_type)
          .then((res) => {
            this.allItems = res.data;
          })
          .catch((err) => {});
      } else if (this.form.product_type.toLowerCase() == "others") {
        this.isProject = true;
        axios
          .get("/api/filterUnit/" + this.form.product_type)
          .then((res) => {
            this.allItems = res.data;
          })
          .catch((err) => {});
      }
    },
    chooseProject() {
      axios
        .get("/api/fetchBuildingInventory/" + this.form.selectedProject)
        .then((res) => {
          this.buildings = res.data;
          console.log(this.buildings);
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
  },
};
</script>
<style>
.formBox {
  border: 1px solid #4e3089;
  margin: 1rem;
  box-sizing: border-box;
  width: 100%;
}
.depositorBox {
  font-size: 0.85em;
}

.box_container {
  display: flex;
}
.title_col {
  width: 60%;
}
.plusBtn {
  width: 100%;
  display: flex;
}
.plusSection {
  width: 100%;
  display: flex;
}
.faBtn {
  text-align: right;
  margin-top: 3em;
  padding-right: 3%;
  margin-bottom: 1em;
}
.faBtnCross button {
  background: red;
  margin-top: 2em;
  color: white;
  border: none;
  border-radius: 10%;
}
.faBtn button {
  background: #5252d7;
  color: white;
  border: none;
  border-radius: 10%;
}
.cashSection {
  padding: 2rem 0;
}
.additionalPart {
  width: 100%;
  color: black;
  margin: 1rem 2rem;
}
.two_group {
  display: flex;
}
@media only screen and (max-width: 900px) {
  .title_col {
    width: 100%;
  }
}
</style>
