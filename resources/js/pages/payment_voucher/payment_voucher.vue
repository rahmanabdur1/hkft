<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">Create Cash/Bank Voucher</h2>

    <div class="row">
      <div class="col-md-12">
        <form
          class="form"
          @submit.prevent="receiveVoucher()"
          enctype="multipart/form-data"
        >
          <div class="row box_container">
            <div class="col-md-5 formBox">
              <h4 class="hkf_title">Basic Information:</h4>
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
              <div class="form-group mx-sm-3 mb-2">
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
            <div class="col-md-5 formBox depositorBox">
              <h4 class="hkf_title">Supplier's Information:</h4>

              <div class="form-group mx-sm-3 mb-2 two_group">
                <div>
                  <label class="hkf_text">Supplier's Name</label>
                  <div style="display: flex">
                    <input
                      type="text"
                      class="form-control status"
                      placeholder="Supplier Name"
                      v-model="client_search"
                      @keyup="listDisplay"
                    />
                  </div>
                  <div>
                    <ul class="ulShow" :class="{ listStyle: list_style }">
                      <li
                        class="listShow"
                        :class="{ listStyle: list_style }"
                        v-for="(item, index) in filterSearch"
                        :key="index"
                        :value="item.supplier_name"
                        @click="assignToSearch(item)"
                      >
                        {{ item.supplier_name }}
                      </li>
                    </ul>
                  </div>
                </div>

                <div>
                  <label class="hkf_text">TIN</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="TIN"
                    v-model="form.payee_tin"
                  />
                </div>
              </div>

              <div class="form-group mx-sm-3 mb-2 two_group">
                <div>
                  <label class="hkf_text">Supplier's mobile no:</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="mobile no"
                    v-model="form.payee_phone"
                    required
                  />
                </div>
                <div>
                  <label class="hkf_text">Supplier's Email:</label>
                  <input
                    type="email"
                    class="form-control"
                    placeholder="email"
                    v-model="form.payee_email"
                  />
                </div>
              </div>
              <div class="form-group mx-sm-3 mb-2" v-if="isAdmin">
                <label for="projectName" class="hkf_text">Select Product Type</label>
                <select
                  class="form-control status"
                  id="status"
                  v-model="form.product_type"
                  @change="chooseProductType"
                  required
                >
                  <option
                    v-for="(project, index) in product_types"
                    :key="index"
                    :value="project.value"
                  >
                    {{ project.label }}
                  </option>
                </select>
              </div>
              <div class="form-group mx-sm-3 mb-2" v-if="isManager">
                <label for="projectName" class="hkf_text">Select Product Type</label>
                <select
                  class="form-control status"
                  id="status"
                  v-model="form.product_type"
                  @change="chooseProductType"
                  required
                >
                  <option
                    v-for="(project, index) in product_types_manager"
                    :key="index"
                    :value="project.value"
                  >
                    {{ project.label }}
                  </option>
                </select>
              </div>
              <div class="form-group mx-sm-3 mb-2" v-if="isProject && isAdmin">
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
              <div class="form-group mx-sm-3 mb-2" v-if="isProject && isManager">
                <label for="projectName" class="hkf_text">Select Project</label>
                <select
                  class="form-control status"
                  id="status"
                  v-model="form.selectedProject"
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
              <div class="form-group mx-sm-3 mb-2" v-if="isBuilding">
                <label for="projectName" class="hkf_text">Select Building</label>
                <select
                  class="form-control status"
                  id="status"
                  v-model="this.form.building_name"
                  onfocus="this.size=10"
                  onblur="this.size=1"
                  onchange="this.size=1;this.blur();"
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
              <div class="form-group mx-sm-3 mb-2" v-if="!isLand">
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
              <div class="form-group mx-sm-3 mb-2" v-if="!isLand">
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
              <div class="form-group mx-sm-3 mb-2 two_group">
                <div>
                  <label class="hkf_text">Product Name:</label>
                  <select
                    class="form-control status"
                    id="status"
                    v-model="form.product_name"
                    @change="selectUnit"
                    required
                  >
                    <option
                      v-for="(item, index) in allItems"
                      :key="index"
                      :value="item.item_name"
                    >
                      {{ item.item_name }}
                    </option>
                  </select>
                </div>

                <div>
                  <label class="hkf_text">Per Unit Cost:</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="Per Unit Cost"
                    v-model="form.per_unit_price"
                    @keyup="fullPrice"
                    required
                  />
                </div>
              </div>

              <div class="form-group mx-sm-3 mb-2 two_group">
                <div>
                  <label class="hkf_text">Quantity:</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="Quantity"
                    v-model="form.qty"
                    @keyup="fullPrice"
                    required
                  />
                </div>
                <div>
                  <label class="hkf_text">Unit:</label>
                  <div style="padding: 5px">
                    <label class="hkf_text">{{ this.form.item_unit }}</label>
                  </div>
                </div>
              </div>

              <div class="form-group mx-sm-3 mb-2" v-if="isLand">
                <div>
                  <label class="hkf_text"> Daag No:</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="Daag No:"
                    v-model="form.ledger_no"
                    required
                  />
                </div>
              </div>
              <div class="form-group mx-sm-3 mb-2 two_group">
                <div>
                  <label class="hkf_text">Total Price:</label>
                  <span class="hkf_text" style="margin-right: 2px">{{
                    form.total_amount
                  }}</span
                  ><span class="hkf_text">tk</span>
                </div>
              </div>
              <div class="form-group mx-sm-3 mb-2 two_group">
                <label class="hkf_text">Due Amount:</label>
                <span class="hkf_text" style="margin-right: 2px">{{
                  form.payment_due
                }}</span
                ><span class="hkf_text">tk</span>
              </div>
              <div class="form-group mx-sm-3 mb-2 two_group">
                <span
                  class="hkf_text"
                  style="margin-right: 2px; color: red !important"
                  v-if="excess_receive"
                  >{{ excess_receive_msg }}</span
                >
              </div>
            </div>
            <div class="row formBox mx-auto cashSection" v-if="bankChoose">
              <div class="col-md-12">
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

            <div class="row formBox mx-auto cashSection">
              <div class="row additionalPart">
                <div class="col-md-6">
                  <label class="hkf_text">Purchased Amount</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="Purchased Amount"
                    v-model="form.receive_amount"
                    @keyup="fullPrice"
                  />
                </div>
              </div>
              <div class="row additionalPart">
                <div class="col-md-6">
                  <label class="hkf_text">Payment Details (Narration)</label>
                  <input
                    type="text"
                    class="form-control col-md-8"
                    placeholder="Enter Payment Details(Narration)..."
                    v-model="form.payment_details"
                  />
                </div>
                <div class="col-md-6" style="padding: 1rem">
                  <label class="hkf_text">Attach File</label>
                  <input
                    type="file"
                    class="col-md-8"
                    placeholder="Enter Payment Details(Narration)..."
                    @change="selectedDocs"
                  />

                  <embed :src="Supporting_docs" type="application/pdf" />
                </div>
              </div>
            </div>
          </div>

          <button type="submit" class="btn btn-primary mb-2" v-show="showSubmit">
            Save
          </button>
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
        vm.$router.push({ name: "payment_voucher" });
      }
    });
  },

  data() {
    return {
      category_name_search: "",
      category_id_search: "",
      list_style_category_id: true,
      list_style_category_name: true,
      categories: [],
      list_style: true,
      isBuilding: false,
      buildings: [],
      allProjects: [],
      product_types: [
        { value: "land", label: "Land" },
        { value: "others", label: "Others" },
      ],
      product_types_manager: [{ value: "others", label: "Others" }],

      bankChoose: false,
      form: {
        category_name: "",
        category_id: "",
        financialYear: "",
        basic_date: "",
        selectedPaymentType: "",
        cash_bank_account: "",
        payee_name: "",
        selectedProject: "",
        payee_tin: "",
        payee_email: "",
        payee_phone: "",
        product_name: "",
        bank_cheque_no: "",
        bank_cheque_date: "",
        bank_name: "",
        bank_branch: "",
        receive_amount: "",
        payment_id: "",
        Supporting_docs: "",
        payment_details: "",
        per_unit_price: "",
        qty: "",
        total_amount: "",
        payment_due: "",
        item_unit: "",
        item_id: "",
        payee_id: "",
        account_type: "",
        ledger_no: "",
        product_type: "",
        building_name: "",
      },
      client_search: "",
      isProject: false,
      isLand: false,
      showSubmit: true,
      allItems: [],
      suppliers: [],
      product_name: "",
      excess_receive: false,
      excess_receive_msg: "Purchased Amount Is Greater Than Product Price",
      Supporting_docs: "",
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
      this.isAdmin = true;
      this.isManager = false;
      axios
        .get("/api/project")
        .then((res) => {
          this.allProjects = res.data;
        })
        .catch((err) => {});
    } else if (this.guard == "manager") {
      this.isManager = true;
      this.isAdmin = false;
      this.manager_username = User.getUserName();
      axios
        .get("/api/getManagerProject/" + this.manager_username)
        .then((res) => {
          this.projects = res.data;
        })
        .catch((err) => {});
    }
    axios
      .get("/api/category")
      .then((res) => {
        this.categories = res.data;
      })
      .catch((err) => {
        console.log(err.response);
      });
    //end
  },
  methods: {
    listDisplay() {
      this.list_style = false;
    },
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
    assignToSearch(item) {
      this.client_search = item.supplier_name;
      this.form.payee_name = item.supplier_name;
      this.form.payee_phone = item.phone;
      this.form.payee_id = item.supplier_id;
      this.list_style = true;
      console.log(this.form);
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
      this.form.account_type =
        "Installation-" + Math.floor(Math.random() * 9999999) + uniqueId;
      //payment_account

      const formData = new FormData();
      formData.append("category_name", this.form.category_name);
      formData.append("category_id", this.form.category_id);
      formData.append("financialYear", this.form.financialYear);
      formData.append("basic_date", this.form.basic_date);
      formData.append("selectedPaymentType", this.form.selectedPaymentType);
      formData.append("cash_bank_account", this.form.cash_bank_account);
      formData.append("payee_name", this.form.payee_name);
      formData.append("payee_id", this.form.payee_id);
      formData.append("payee_tin", this.form.payee_tin);
      formData.append("payee_email", this.form.payee_email);
      formData.append("payee_phone", this.form.payee_phone);
      formData.append("product_name", this.form.product_name);
      formData.append("bank_cheque_no", this.form.bank_cheque_no);
      formData.append("bank_cheque_date", this.form.bank_cheque_date);
      formData.append("bank_name", this.form.bank_name);
      formData.append("bank_branch", this.form.bank_branch);
      formData.append("receive_amount", this.form.receive_amount);
      formData.append("payment_id", this.form.payment_id);
      formData.append("Supporting_docs", this.form.Supporting_docs);
      formData.append("payment_details", this.form.payment_details);
      formData.append("selectedProject", this.form.selectedProject);
      formData.append("per_unit_price", this.form.per_unit_price);
      formData.append("qty", this.form.qty);
      formData.append("total_amount", this.form.total_amount);
      formData.append("payment_due", this.form.payment_due);
      formData.append("item_id", this.form.item_id);
      formData.append("item_unit", this.form.item_unit);
      formData.append("account_type", this.form.account_type);
      formData.append("ledger_no", this.form.ledger_no);
      formData.append("building_name", this.form.building_name);
      //payment_voucher
      axios
        .post("/api/payment_voucher", formData, {
          headers: {
            "Content-Type": "multipart/form-data",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.$router.push({ name: "payment_all_voucher" });
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

    chooseProject() {
      this.isBuilding = true;
      axios
        .get("/api/fetchSelectedProject/" + this.form.selectedProject)
        .then((res) => {
          console.log(res.data);
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
        .get("/api/unit/getUnitItem/" + this.form.product_name)
        .then((res) => {
          console.log(res.data);
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
          this.form.payee_phone = supplier.supplier_phone;
        }
      });
    },
    chooseProductType() {
      if (this.form.product_type.toLowerCase() == "land") {
        this.form.building_name = "";
        this.form.selectedProject = "";
        this.isProject = false;
        axios
          .get("/api/filterUnit/" + this.form.product_type)
          .then((res) => {
            this.allItems = res.data;
          })
          .catch((err) => {});
      } else if (this.form.product_type.toLowerCase() == "others") {
        this.isProject = true;
        this.form.ledger_no = "";
        axios
          .get("/api/filterUnit/" + this.form.product_type)
          .then((res) => {
            this.allItems = res.data;
          })
          .catch((err) => {});
      }
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
