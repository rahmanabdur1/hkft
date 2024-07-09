<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">Add Employee</h2>
    <div class="input-group col-md-6 page_to_page">
      <router-link :to="{ name: 'all_employee' }" class="btn btn-primary"
        >All Employee</router-link
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
            <div class="col-md-8 mx-auto formBox">
              <div class="form-group mx-sm-3 mb-2">
                <label class="hkf_text">Employee Name</label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Employee Name"
                  v-model="form.employee_name"
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
                <label class="hkf_text">Employee Designation</label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Employee Designation"
                  v-model="form.employee_designation"
                  required
                />
              </div>
              <div class="form-group mx-sm-3 mb-2">
                <label class="hkf_text">Employee Address</label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Employee Address"
                  v-model="form.employee_address"
                />
              </div>
              <div class="form-group mx-sm-3 mb-2">
                <label class="hkf_text">Employee Phone</label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Employee Phone"
                  v-model="form.employee_phone"
                />
              </div>
              <div class="form-group mx-sm-3 mb-2">
                <label class="hkf_text">Basic Salary</label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Basic Salary"
                  v-model="form.basic_salary"
                  required
                />
              </div>
              <div class="form-group mx-sm-3 col-md-6">
                <label for="location" class="hkf_text">CV</label>
                <input
                  type="file"
                  class="form-control-file col-md-6"
                  @change="selectedDocs"
                />

                <embed :src="Supporting_docs" type="application/pdf" />
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
  name: "add_employee",
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else {
        vm.$router.push({ name: "add_employee" });
      }
    });
  },

  data() {
    return {
      admin: false,
      manager: false,
      Supporting_docs: "",

      allProjects: [],
      product_types: [
        { value: "land", label: "Land" },
        { value: "others", label: "Others" },
      ],
      bankChoose: false,
      form: {
        selectedProject: "",
        employee_name: "",
        employee_address: "",
        employee_phone: "",
        employee_designation: "",
        basic_salary: "",
        employee_id: "",
        cv: "",
        building_name: "",
      },
      isProject: false,
      isLand: false,
      showSubmit: true,
      allItems: [],
      suppliers: [],
      buildings: [],
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
      .catch((err) => {
        console.log(err.response);
      });
    //admin  & manager
    this.guard = User.getGuard();
    if (this.guard == "admin") {
      this.admin = true;
      this.manager = false;
      axios
        .get("/api/project/")
        .then((res) => {
          this.allProjects = res.data;
        })
        .catch((err) => {
          console.log(err);
        });
    } else if (this.guard == "manager") {
      this.manager = true;
      this.admin = false;
      this.manager_username = User.getUserName();
      axios
        .get("/api/getManagerProject/" + this.manager_username)
        .then((res) => {
          this.allProjects = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });
    }
    //end
  },
  methods: {
    receiveVoucher() {
      const alphabet = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz";
      let randomString = "";
      for (let i = 0; i < 5; i++) {
        const randomIndex = Math.floor(Math.random() * alphabet.length);
        const randomLetter = alphabet.charAt(randomIndex);
        randomString += randomLetter;
      }
      const uniqueId = randomString + "-" + Math.floor(Math.random() * 100000);

      this.form.employee_id = uniqueId;
      //payment_account

      //payment_voucher
      const formData = new FormData();
      formData.append("selectedProject", this.form.selectedProject);
      formData.append("employee_name", this.form.employee_name);
      formData.append("employee_address", this.form.employee_address);
      formData.append("employee_phone", this.form.employee_phone);
      formData.append("employee_designation", this.form.employee_designation);
      formData.append("basic_salary", this.form.basic_salary);
      formData.append("employee_id", this.form.employee_id);
      formData.append("cv", this.form.cv);
      formData.append("building_name", this.form.building_name);
      axios
        .post("/api/employee", formData, {
          headers: {
            "Content-Type": "multipart/form-data",
            Accept: "application/json",
          },
        })
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
        this.form.cv = file;
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
