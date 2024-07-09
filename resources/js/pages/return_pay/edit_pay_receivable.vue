<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">Clients Due Payment!</h2>
    <div class="input-group col-md-6 page_to_page">
      <router-link :to="{ name: 'all_pay_receivable' }" class="btn btn-primary"
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
              <h4 class="hkf_title">Due Information:</h4>

              <div class="form-group mx-sm-3 mb-2">
                <label for="projectName" class="hkf_text">Search Payment Voucher:</label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Receipt Voucher ID"
                  v-model="form.receipt_id"
                  disabled
                />
              </div>

              <div class="form-group mx-sm-3 mb-2">
                <label class="hkf_text">Due:</label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Due .. "
                  v-model="form.due"
                  disabled
                />
              </div>

              <div class="form-group mx-sm-3 mb-2">
                <label class="hkf_text">Pay Amount</label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Pay Amount.."
                  v-model="form.receive_amount"
                  @keyup="calculateTotal"

                />
              </div>
              <div class="form-group mx-sm-3 mb-2">
                <label class="hkf_text">Current Amount </label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Current Amount.."
                  v-model="form.current_amount"
                  @keyup="changeTotal"
                />
              </div>
              <div class="form-group mx-sm-3 mb-2 two_group">
                <div>
                  <label class="hkf_text">Remaining Due:</label>
                  <span class="hkf_text" style="margin-right: 2px"
                    >{{ form.second_due }} tk</span
                  >
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
                    form.client_name
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
      } else if (User.getGuard() == "manager") {
        axios.get("/api/fetch_access/" + User.getUserName()).then((res) => {
          if (User.getUserName() != res.data.manager_name) {
            vm.$router.push({ name: "manager_dashboard" });
          }
        });
      } else {
        vm.$router.push({ name: "edit_pay_receivable" });
      }
    });
  },

  data() {
    return {
      payment_id_search: "",
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
        due: "",
        second_due: "",
        old_payment_id: "",
        old_receive_amount: "",
        current_amount: 10,
      },
      tempAmount: 0,
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
      stror: "",
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

    axios
      .get("/api/receipt_payable/" + this.$route.params.id)
      .then((res) => {
        this.form = res.data;
        this.form.current_amount = 0;
        this.form.old_payment_id = res.data.payment_id;
        this.form.old_receive_amount = res.data.receive_amount;
        this.form.due = res.data.due;
        this.form.second_due = res.data.second_due;
        this.store = res.data.receive_amount;
      })
      .catch((err) => {
        console.log(err.response);
      });
  },

  methods: {
    receiveVoucher() {
      axios
        .patch("/api/receipt_payable/" + this.$route.params.id, this.form, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.$router.push({ name: "all_pay_receivable" });
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
  },
  computed: {
    changeTotal() {
      let current_amount = this.form.current_amount;
      let receive_amount = this.form.receive_amount;

      if (this.form.current_amount == "") {
        this.form.receive_amount = this.store;
        this.receive_amount = this.store;
        current_amount = 0;
        this.form.current_amount = 0;
      }
      let due = this.form.due;
      let totalAmount =
        -parseInt(this.tempAmount) + parseInt(current_amount) + parseInt(receive_amount);
      this.form.receive_amount = totalAmount;

      if (totalAmount == due) {
        this.showSubmit = true;
        this.form.second_due = 0;
        this.excess_receive = false;
      } else if (due > totalAmount) {
        this.showSubmit = true;
        this.form.second_due = due - totalAmount;
        this.excess_receive = false;
      } else {
        this.showSubmit = false;
        this.form.second_due = 0;
        this.excess_receive = true;
        this.excess_receive_msg = "Purchased Amount Is Greater Than Product Price";
      }
      this.tempAmount = this.form.current_amount;
    },
    calculateTotal() {
      let due = parseInt(this.form.due);
      let receive_amount = parseInt(this.form.receive_amount);

      if (receive_amount == due) {
        this.showSubmit = true;
        this.form.second_due = 0;
        this.excess_receive = false;
      } else if (due > receive_amount) {
        this.showSubmit = true;
        this.form.second_due = due - receive_amount;
        this.excess_receive = false;
      } else {
        this.showSubmit = false;
        this.form.second_due = 0;
        this.excess_receive = true;
        this.excess_receive_msg = "Purchased Amount Is Greater Than Product Price";
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

    listDisplay() {
      if (this.payment_id_search != null) {
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
