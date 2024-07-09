<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">Pay Employee - {{ form.employee_name }}</h2>

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
                <label for="projectName" class="hkf_text">Date</label>
                <input
                  type="date"
                  class="form-control"
                  v-model="form.basic_date"
                  required
                />
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
                  <label class="hkf_text">Paid Month: {{form.paid_month}}</label>
                  <select
                    class="form-control"
                    id="status"
                    name="status"
                    v-model="form.paid_month"
                    required
                  >
                    <option
                      v-for="(month, index) in months"
                      :key="index"
                      :value="month.value"
                    >
                      {{ month.label }}
                    </option>
                  </select>
                </div>
              </div>
              <div class="row additionalPart">
                <div class="col-md-10">
                  <label class="hkf_text">Paid Year</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="Year"
                    v-model="form.paid_year" required
                  />
                </div>
              </div>
              <div class="row additionalPart">
                <div class="col-md-10">
                  <label class="hkf_text">Commission </label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="Commission"
                    v-model="form.commission"
                  />
                </div>
              </div>
            </div>
          </div>

          <div class="col-md-8 mx-auto" style="text-align: right">
            <button type="submit" class="btn btn-primary mb-2">Save</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "edit_salary",
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else {
        vm.$router.push({ name: "edit_salary" });
      }
    });
  },

  data() {
    return {
      allProjects: [],
      product_types: [
        { value: "land", label: "Land" },
        { value: "others", label: "Others" },
      ],
      bankChoose: false,
      form: {
        basic_date: "",
        selectedPaymentType: "",
        cash_bank_account: "",
        selectedProject: "",
        employee_name: "",
        employee_address: "",
        employee_phone: "",
        employee_designation: "",
        bank_cheque_no: "",
        bank_cheque_date: "",
        bank_name: "",
        bank_branch: "",
        basic_salary: "",
        commission: "",
        employee_id: "",
        paid_month: "",
        paid_year: "",
      },
       months:[
        {value:'January', label: 'January'},
        {value:'February', label: 'February'},
        {value:'March', label: 'March'},
        {value:'April', label: 'April'},
        {value:'May', label: 'May'},
        {value:'June', label: 'June'},
        {value:'July', label: 'July'},
        {value:'August', label: 'August'},
        {value:'September', label: 'September'},
        {value:'October', label: 'October'},
        {value:'November', label: 'November'},
        {value:'December', label: 'December'},

      ],
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
      .catch((err) => {
        console.log(err.response);
      });
    axios
      .get("/api/project")
      .then((res) => {
        this.allProjects = res.data;
      })
      .catch((err) => {
        console.log(err);
      });


      axios.get('/api/salary/'+this.$route.params.id).then((res)=>{
        this.form = res.data;
      }).catch((err)=>{
        console.log(err.response);
      });
  },
  methods: {
    receiveVoucher() {


      //payment_voucher
      axios
        .patch("/api/salary/"+this.$route.params.id, this.form,  {
                  headers: {
                   "Content-Type": "application/json",
                    "Accept": "application/json",
                  },
                }

)
        .then((res) => {
          this.$router.push({ name: "all_employee" });
        })
        .catch((err) => {
          console.log(err);
        });
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
        .catch((err) => {
          console.log(err.response);
        });
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
          .catch((err) => {
            console.log(err.response.data);
          });
      } else if (this.form.product_type.toLowerCase() == "others") {
        this.isProject = true;
        axios
          .get("/api/filterUnit/" + this.form.product_type)
          .then((res) => {
            this.allItems = res.data;
          })
          .catch((err) => {
            console.log(err.response.data);
          });
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
