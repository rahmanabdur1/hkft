<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">Stock Transfer</h2>
    <h3 class="text-center mb-4 hkf_text">
      Transfer From: {{ form.fromProject }} Project
    </h3>
    <h3 class="text-center mb-4 hkf_text">
      Transfer From: {{ form.fromBuilding }} Building
    </h3>
    <div class="input-group col-md-6 page_to_page">
      <router-link :to="{ name: 'all_stock_transfer' }" class="btn btn-primary"
        >Stock Transfer</router-link
      >
    </div>

    <div class="row">
      <div class="col-md-6">
        <form class="form" @submit.prevent="addAccountHead()">
          <div class="form-group mx-sm-3 mb-2">
            <label for="projectName" class="hkf_text">Date</label>
            <input type="date" class="form-control" v-model="form.basic_date" required />
          </div>
          <div class="form-group mx-sm-3 mb-2">
            <label class="hkf_text">Transfered Product</label>
            <input
              type="text"
              class="form-control"
              v-model="form.product_name"
              required
              disabled
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
            <label for="projectName" class="hkf_text">Select Building:</label>
            <select
              class="form-control status"
              id="status"
              v-model="form.selectedBuilding"
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
          <div class="form-group mx-sm-3 mb-2">
            <label class="hkf_text">Total Quantity</label>
            <input
              type="text"
              class="form-control"
              placeholder="Total Quantity"
              v-model="form.total_quantity"
              required
              disabled
            />
          </div>
          <div class="form-group mx-sm-3 mb-2">
            <label class="hkf_text">Transfer Quantity</label>
            <input
              type="text"
              class="form-control"
              placeholder="Transfer Quantity"
              v-model="form.quanity"
              @keyup="calculate"
              required
            />
          </div>
          <div class="form-group mx-sm-3 mb-2">
            <label class="hkf_text">Purpose</label>
            <input
              type="text"
              class="form-control"
              placeholder="Purpose.."
              v-model="form.purpose"
            />
          </div>
          <div class="form-group mx-sm-3 mb-2">
            <label class="hkf_text">Description</label>
            <input
              type="text"
              class="form-control"
              placeholder="Description.."
              v-model="form.note"
            />
          </div>
          <div class="form-group mx-sm-3 mb-2">
            <label class="hkf_text">Attach File</label>
            <input
              type="file"
              class="col-md-8"
              placeholder="Documents..."
              @change="selectedDocs"
            />

            <embed :src="Supporting_docs" type="application/pdf" />
          </div>

          <button type="submit" class="btn btn-primary mb-2" v-if="!hideButton">
            Save
          </button>
        </form>
        <small class="text text-danger" v-if="errors.type_name">{{
          errors.type_name[0]
        }}</small>
        <small class="text text-danger" v-if="hideButton">{{ msg }}</small>
        <small class="text text-danger" v-if="hideButton">{{ errmsg }}</small>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "add_account_type",

  data() {
    return {
      form: {
        product_name: "",
        selectedProject: "",
        total_quantity: "",
        quantity: "",
        oldQuantity: "",
        note: "",
        purpose: "",
        selectedBuilding: "",
        fromProject: "",
        fromBuilding: "",
        Supporting_docs: "",
        unit: "",
        basic_date: "",
        id: "",
      },
      Supporting_docs: "",

      hideButton: false,
      errmsg: "",
      msg: "",
      projects: [],
      products: [],
      errors: {},
      allProjects: [],
      buildings: [],
    };
  },
  created() {
    if (!User.hasLoggedIn()) {
      this.$router.push({ name: "home" });
    } else {
      this.$router.push({ name: "edit_stock_transfer" });
    }
    axios
      .get("/api/stock_transfer/" + this.$route.params.id)
      .then((res) => {
        console.log(res.data);
        this.form = res.data;
        this.form.oldQuantity = res.data.quanity;
        axios
          .get("/api/fetchBuildingByProjectInStock/" + this.form.selectedProject)
          .then((res) => {
            this.buildings = res.data;
            console.log(res.data);
          })
          .catch((err) => {
            console.log(err.response);
          });

        axios
          .post("/api/getTransferedQuantity", this.form, {
            headers: {
              "Content-Type": "application/json",
              Accept: "application/json",
            },
          })
          .then((res) => {
            this.form.total_quantity = res.data.quantity;
            console.log(res.data);
          })
          .catch((err) => {
            console.log(err.response);
          });
      })
      .catch((err) => {
        console.log(err.response);
      });
    axios
      .get("/api/stock_journal")
      .then((res) => {
        this.products = res.data;
      })
      .catch((err) => {
        console.log(err.response);
      });
    //admin  & manager
    this.guard = User.getGuard();
    if (this.guard == "admin") {
      this.admin = true;
      this.manager = false;
      axios;
      axios
        .get("/api/project")
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
    selectedDocs() {
      let file = event.target.files[0];
      let reader = new FileReader();
      reader.onload = (event) => {
        this.Supporting_docs = event.target.result;
        this.form.Supporting_docs = file;
      };

      reader.readAsDataURL(file);
    },
    addAccountHead() {
      const formData = new FormData();
      formData.append("product_name", this.form.product_name);
      formData.append("selectedProject", this.form.selectedProject);
      formData.append("total_quantity", this.form.total_quantity);
      formData.append("quanity", this.form.quanity);
      formData.append("oldQuantity", this.form.oldQuantity);

      formData.append("note", this.form.note);
      formData.append("purpose", this.form.purpose);
      formData.append("selectedBuilding", this.form.selectedBuilding);
      formData.append("basic_date", this.form.basic_date);
      formData.append("fromProject", this.form.fromProject);
      formData.append("fromBuilding", this.form.fromBuilding);
      formData.append("Supporting_docs", this.form.Supporting_docs);
      formData.append("unit", this.form.unit);
      formData.append("id", this.form.id);
      console.log(this.form);
      axios
        .post("/api/stock_transfer_update", formData, {
          headers: {
            "Content-Type": "multipart/form-data",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.$router.push({ name: "all_stock_transfer" });
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
  },
  computed: {
    calculate() {
      if (parseInt(this.form.total_quantity) < parseInt(this.form.quanity)) {
        this.hideButton = true;
        this.msg = "Consumed quantity can't  be greater than total quantity";
      } else {
        this.hideButton = false;
        this.msg = "";
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
