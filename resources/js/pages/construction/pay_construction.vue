<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">Construction Cost</h2>
    <div class="input-group col-md-6 page_to_page">
      <router-link :to="{ name: 'all_pay_construction' }" class="btn btn-primary">
        Construction Paid Lists</router-link
      >
    </div>
    <div class="row">
      <div class="col-md-12 mx-auto">
        <form @submit.prevent="addProject()">
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="projectName" class="hkf_text">Date</label>
            <input type="date" class="form-control" v-model="form.basic_date" required />
          </div>

          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="projectName" class="hkf_text">Selected Project</label>
            <input
              type="text"
              class="form-control"
              v-model="form.selectedProject"
              required
              disabled
            />
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="projectName" class="hkf_text">Selected Building</label>
            <input
              type="text"
              class="form-control"
              v-model="form.selectedBuilding"
              required
              disabled
            />
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="projectName" class="hkf_text">Client Name</label>
            <input
              type="text"
              class="form-control"
              v-model="form.client_name"
              required
              disabled
            />
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
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
          <div class="form-group mx-sm-3 col-md-6 mb-2" v-if="showBankField">
            <label class="hkf_text">Cash/Bank Account</label>
            <input
              type="text"
              class="form-control"
              placeholder="Cash/Bank Account"
              v-model="form.cash_bank_account"
            />
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2" v-if="showBankField">
            <label class="hkf_text">Cheque No</label>
            <input
              type="text"
              class="form-control"
              placeholder="Cheque No"
              v-model="form.bank_cheque_no"
            />
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2" v-if="showBankField">
            <label class="hkf_text">Cheque Date</label>
            <input
              type="date"
              class="form-control"
              placeholder="Cheque Date"
              v-model="form.bank_cheque_date"
            />
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2" v-if="showBankField">
            <label class="hkf_text">Issuing Bank Name</label>
            <input
              type="text"
              class="form-control"
              placeholder="Enter Issuing Bank Name"
              v-model="form.bank_name"
            />
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2" v-if="showBankField">
            <label class="hkf_text">Issuing Branch Name</label>
            <input
              type="text"
              class="form-control"
              placeholder="Enter Issuing Branch Name"
              v-model="form.bank_branch"
            />
          </div>

          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Pay Amount</label>
            <input
              type="text"
              class="form-control"
              placeholder="Amount"
              v-model="form.paid_amount"
              required
            />
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Received By</label>
            <input
              type="text"
              class="form-control"
              placeholder="Receiver Name"
              v-model="form.receieved_by"
            />
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Physical Voucher</label>
            <input
              type="text"
              class="form-control"
              placeholder="Voucher"
              v-model="form.physical_voucher"
              required
            />
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label class="hkf_text">Attach File</label>
            <input
              type="file"
              class="col-md-8"
              placeholder="Enter Details(Narration)..."
              @change="selectedDocs"
            />

            <embed :src="Supporting_docs" type="application/pdf" />
          </div>
          <div class="col-md-6 text-right">
            <button type="submit" class="btn btn-primary mb-2">Save</button>
          </div>
          <!-- -->
        </form>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else {
        vm.$router.push({ name: "pay_construction" });
      }
    });
  },
  data() {
    return {
      admin: false,
      manager: false,
      logo: "",
      isBuilding: false,
      projects: [],
      buildings: [],
      allClients: [],
      client_nid: "",
      list_style: true,
      client_search: "",
      allProjects: [],
      showBankField: false,
      payment_types: [
        { payment_type: "Cash", label: "Cash" },
        { payment_type: "Cheque", label: "Cheque" },
      ],
      form: {
        due_date: "",
        selectedProject: "",
        selectedBuilding: "",
        paid_amount: "",
        note: "",
        client_name: "",
        basic_date: "",
        client_id: "",
        all_client: "",
        clients: [],
        id: "",
        physical_voucher: "",
        bank_cheque_no: "",
        bank_cheque_date: "",
        bank_name: "",
        bank_branch: "",
        selectedPaymentType: "",
        cash_bank_account: "",
        Supporting_docs: "",
        receieved_by: "",
      },
      Supporting_docs: "",
    };
  },
  created() {
    if (User.getGuard() == "admin") {
      axios.get("/api/project").then((res) => {
        this.admin = true;
        this.manager = false;
        this.projects = res.data;
      });
    } else if (User.getGuard() == "manager") {
      this.manager = true;
      this.admin = false;
      let manager_name = User.getUserName();
      axios
        .get("/api/getManagerProject/" + manager_name)
        .then((res) => {
          this.allProjects = res.data;
        })
        .catch((err) => {});
    }

    axios
      .get("/api/construction/" + this.$route.params.id)
      .then((res) => {
        this.form = res.data;
        console.log(this.form);
        this.form.id = this.$route.params.id;

        this.form.paid_amount = "";
      })
      .catch((err) => {
        console.log(err.response);
      });
  },
  methods: {
    selectedDocs() {
      let file = event.target.files[0];
      let reader = new FileReader();
      reader.onload = (event) => {
        this.Supporting_docs = event.target.result;
        this.form.Supporting_docs = file;
      };

      reader.readAsDataURL(file);
    },
    listDisplay() {
      this.list_style = false;
    },
    assignToSearch(item) {
      this.client_search = item.name;
      this.list_style = true;

      this.form.client_name = item.name;
      this.form.client_id = item.client_id;
      this.form.all_client = "";
    },
    assignToSearch2() {
      this.list_style = true;

      this.form.all_client = "all";
      this.client_search = "All";
      this.form.clients = this.allClients;
    },
    addProject() {
      axios
        .post("/api/pay_construction", this.form, {
          headers: {
            "Content-Type": "multipart/form-data",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.$router.push({ name: "all_pay_construction" });
          console.log(res.data);
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
  },
  computed: {
    choosePaymentType() {
      if (this.form.selectedPaymentType == "Cash") {
        this.bankChoose = false;
        this.showBankField = false;
      } else if (this.form.selectedPaymentType == "Cheque") {
        this.bankChoose = true;
        this.showBankField = true;
      }
    },
    chooseProject() {
      this.client_search = "";
      this.isBuilding = true;
      axios
        .get("/api/fetchClientByProject/" + this.form.selectedProject)
        .then((res) => {
          this.allClients = res.data;
        })
        .catch((err) => {
          console.log(err.response);
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
    },
    filterClient() {
      return this.allClients.filter((product) => {
        let product_name = this.client_search.toUpperCase();
        let productLedger = product.name.toUpperCase();
        return productLedger.match(product_name);
      });
    },
  },
};
</script>
<style>
label {
  margin-right: 1em;
}
.hkf_text {
  color: #000000cf !important;
  font-weight: bold;
}
.hkf_title {
  color: #605ca8 !important;
  border-bottom: 1px solid #554e6a;
}
#status {
  color: black;
}

#status option:active {
  background-color: #6e6c8b !important;
  color: #fff;
}
.text-danger {
  color: #e74a3b !important;
  font-size: 1em;
}
</style>
