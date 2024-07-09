<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">Company Due Payment!</h2>
    <div class="input-group col-md-6 page_to_page">
      <router-link :to="{ name: 'all_pay_payable' }" class="btn btn-primary"
        >See Lists</router-link
      >
    </div>
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
                  <option v-for="range,index in yearRanges" :value="range" :key='index'>{{ range }}</option>
                </select>
              </div>
              <div class="form-group mx-sm-3 mb-2" v-if="showDate">
                <label for="projectName" class="hkf_text">Date</label>
                <input
                  type="date"
                  class="form-control"
                  v-model="form.basic_date"
                  @change="calculateDate"
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
              <h4 class="hkf_title">Due Information:</h4>

              <div class="form-group mx-sm-3 mb-2">
                <label for="projectName" class="hkf_text">Search Payment Voucher:</label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Payment Voucher ID"
                  v-model="payment_id_search"
                  @mousedown="listDisplay"
                  required
                />
                <ul class="ulShow" :class="{ listStyle: list_style }">
                  <li
                    class="listShow"
                    :class="{ listStyle: list_style }"
                    v-for="(item, index) in filterPayment"
                    :key="index"
                    :value="item.payment_id"
                    @click="assignToSearch(item)"
                  >
                    {{ item.payment_id }}
                  </li>
                </ul>
              </div>

              <div class="form-group mx-sm-3 mb-2">
                <label class="hkf_text">Due:</label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Due .. "
                  v-model="form.payment_due"
                  disabled
                />
              </div>

              <div class="form-group mx-sm-3 mb-2">
                <label class="hkf_text">Pay Amount </label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Pay Amount.."
                  v-model="form.receive_amount"
                  @keyup="calculateTotal"
                />
              </div>

              <div class="form-group mx-sm-3 mb-2 two_group">
                <div>
                  <label class="hkf_text">Remaining Due:</label>
                  <span class="hkf_text" style="margin-right: 2px">{{
                    form.second_payment_due
                  }}</span>
                </div>
              </div>
              <div class="form-group mx-sm-3 mb-2 two_group">
                <div>
                  <label class="hkf_text">Product Name:</label>
                  <span class="hkf_text" style="margin-right: 2px">{{
                    form.product_name
                  }}</span>
                </div>
              </div>
              <div class="form-group mx-sm-3 mb-2 two_group">
                <div>
                  <label class="hkf_text">Supplier Name:</label>
                  <span class="hkf_text" style="margin-right: 2px">{{
                    form.payee_name
                  }}</span>
                </div>
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
          </div>

          <button type="submit" v-show="showSubmit" class="btn btn-primary mb-2">
            Save
          </button>
        </form>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "pay_payable",
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      }  else {
        vm.$router.push({ name: "pay_payable" });
      }
    });
  },

  data() {
    return {
      payment_id_search: "",
      showDate: false,
      allProjects: [],
      bankChoose: false,
      form: {
        financialYear: "",
        basic_date: "",
        selectedPaymentType: "",
        cash_bank_account: "",
        payee_name: "",
        product_name: "",
        bank_cheque_no: "",
        bank_cheque_date: "",
        bank_name: "",
        bank_branch: "",
        receive_amount: "",
        payment_id: "",
        payment_due: "",
        second_payment_due: "",
        account_type: "",
        current_amount: "",
        selectedProject: "",
      },
      old_basic_date: "",
      list_style: true,
      allItems: [],
      suppliers: [],
      product_id: "",
      excess_receive: false,
      excess_receive_msg: "",
      Supporting_docs: "",
      showBankField: false,
      showSubmit: true,
      payment_types: [
        { payment_type: "Cash", label: "Cash" },
        { payment_type: "Cheque", label: "Cheque" },
      ],
      payments: [],
    };
  },
  created() {
    axios
      .get("/api/supplier")
      .then((res) => {
        this.suppliers = res.data;
      })
      .catch((err) => {
        console.log(err.response);
      });
    if (User.getGuard() == "admin") {
      axios
        .get("/api/pay_payable")
        .then((res) => {
          res.data.forEach((item) => {
            this.payments.push(item);
          });
        })
        .catch((err) => {
          console.log(err.response);
        });
    } else if (User.getGuard() == "manager") {
      axios
        .get("/api/getManagerProject/" + User.getUserName())
        .then((res) => {
          res.data.forEach((item) => {
            axios.get("/api/getManagerPayable/" + item.project).then((res) => {
              res.data.forEach((item) => {
                this.payments.push(item);
              });
            });
          });
        })
        .catch((err) => {
          console.log(err.response);
        });
    }
  },

  methods: {
    assignToSearch(item) {
      this.payment_id_search = item.payment_id;
      this.form.payment_id = item.payment_id;
      this.form.payment_due = Math.abs(item.due);
      this.form.product_name = item.product_name;

      this.old_basic_date = item.payable_date;
      this.showDate = true;
      this.list_style = true;
      axios.get("/api/getPayableName/" + this.form.payment_id).then((res) => {
        this.form.payee_name = res.data.payee_name;
        this.form.selectedProject = res.data.selectedProject;
      });
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

      this.form.account_type = "Due-" + Math.floor(Math.random() * 9999999) + uniqueId;

      axios
        .post("/api/pay_payable", this.form, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.$router.push({ name: "all_pay_payable" });
        })
        .catch((err) => {
          console.log(err.response);
        });
    },

    calculateTotal() {
      let payment_due = parseInt(this.form.payment_due);
      let receive_amount = parseInt(this.form.receive_amount);
      if (receive_amount == payment_due) {
        this.showSubmit = true;
        this.form.second_payment_due = 0;
        this.excess_receive = false;
      } else if (payment_due > receive_amount) {
        this.showSubmit = true;
        this.form.second_payment_due = payment_due - receive_amount;
        this.excess_receive = false;
      } else {
        this.showSubmit = false;
        this.form.second_payment_due = 0;
        this.excess_receive = true;
        this.excess_receive_msg = "Purchased Amount Is Greater Than Product Price";
      }
    },
  },
  computed: {
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

    listDisplay() {
      if (this.form.payment_id != null) {
        this.list_style = false;
      } else {
        this.list_style = true;
      }
    },

    filterPayment() {
      return this.payments.filter((item) => {
        return item.payment_id.match(this.payment_id_search);
      });
    },
    calculateDate() {
      if (this.form.basic_date >= this.old_basic_date) {
        this.excess_receive = false;
        this.showSubmit = true;
      } else {
        this.excess_receive = true;
        this.showSubmit = false;
        this.excess_receive_msg =
          "Due Clear Date Can't Be Earlier Than Purchase Date !! Purchase Date is:" +
          this.old_basic_date;
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
.btn-primary {
  background: rgb(96, 92, 168);
  border: none;
}
.btn-primary:hover {
  background: rgb(96, 92, 168) !important;
  border: none;
}
.ulShow {
  overflow-y: scroll;
  height: 150px;
  display: block;
}
.listShow {
  display: block;
  cursor: pointer;
  padding: 0.2rem;
  color: #4e3089;
}
.listStyle {
  display: none;
}
@media only screen and (max-width: 900px) {
  .title_col {
    width: 100%;
  }
}
</style>
