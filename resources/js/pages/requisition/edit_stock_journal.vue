<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">Edit Stock Valuation</h2>
    <div class="input-group col-md-6 page_to_page">
      <router-link :to="{ name: 'all_stock_journal' }" class="btn btn-primary"
        >All Stock Valuation</router-link
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
            <label class="hkf_text">Select Product</label>
            <select
              class="form-control status"
              id="status"
              v-model="form.product_name"
              required
              @change="chooseProduct"
            >
              <option
                v-for="(product, index) in products"
                :key="index"
                :value="product.product_name"
              >
                {{ product.product_name }}
              </option>
            </select>
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
              v-model="form.selectedBuilding"
              @change="chooseBuilding"
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
              disabled
              required
            />
          </div>
          <div class="form-group mx-sm-3 mb-2">
            <label class="hkf_text">Consume Quantity</label>
            <input
              type="text"
              class="form-control"
              placeholder="Consume Quantity"
              v-model="form.consumeQuantity"
              @keyup="calculate"
              required
            />
          </div>
          <div class="form-group mx-sm-3 mb-2">
            <label class="hkf_text">Description</label>
            <input
              type="text"
              class="form-control"
              placeholder="Description.."
              v-model="form.Description"
            />
          </div>

          <button type="submit" class="btn btn-primary mb-2" v-if="!hideButton">
            Save
          </button>
        </form>
        <small class="text text-danger" v-if="errors.type_name">{{
          errors.type_name[0]
        }}</small>
        <small class="text text-danger" v-if="hideButton">{{ msg }}</small>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "edit_stock_journal",

  data() {
    return {
      form: {
        product_name: "",
        selectedProject: "",
        total_quantity: "",
        consumeQuantity: "",
        Description: "",
        old_product_name: "",
        old_consumeQuantity: "",
        selectedBuilding: "",
        basic_date: "",
      },
      buildings: [],

      hideButton: false,
      msg: "",
      projects: [],
      allProjects: [],
      products: [],
      errors: {},
    };
  },
  created() {
    if (!User.hasLoggedIn()) {
      this.$router.push({ name: "home" });
    } else {
      this.$router.push({ name: "edit_stock_journal" });
    }

    axios
      .get("/api/requisition/" + this.$route.params.id)
      .then((res) => {
        this.form = res.data;
        this.form.old_product_name = res.data.product_name;
        this.form.old_consumeQuantity = res.data.consumeQuantity;
        this.form.selectedBuilding = res.data.building_name;
        this.form.oldSelectedBuilding = res.data.building_name;
        this.form.oldSelectedProject = res.data.selectedProject;
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
          .post("/api/sendForStocks", this.form, {
            headers: {
              "Content-Type": "application/json",
              Accept: "application/json",
            },
          })
          .then((res) => {
            console.log(res.data);
            this.form.total_quantity = res.data.quantity;
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
    addAccountHead() {
      this.calculateMethod();
      if (!this.hideButton) {
        axios
          .patch("/api/requisition/" + this.$route.params.id, this.form, {
            headers: {
              "Content-Type": "application/json",
              Accept: "application/json",
            },
          })
          .then((res) => {
            this.$router.push({ name: "all_stock_journal" });
          })
          .catch((error) => {
            this.errors = JSON.parse(error.response.data);
          });
      }
    },
    calculateMethod() {
      if (parseInt(this.form.total_quantity) < parseInt(this.form.consumeQuantity)) {
        this.hideButton = true;
        this.msg = "Consumed quantity can't  be greater than total quantity";
      } else {
        this.hideButton = false;
        this.msg = "";
      }
    },
  },
  computed: {
    chooseProduct() {
      axios
        .get("/api/fetchStock/" + this.form.product_name)
        .then((res) => {
          this.form.total_quantity = res.data.total_quantity;
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    calculate() {
      if (parseInt(this.form.total_quantity) < parseInt(this.form.consumeQuantity)) {
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
    chooseBuilding() {
      axios
        .post("/api/sendForStocks", this.form, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          console.log(res.data);
          this.form.total_quantity = res.data.quantity;
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
  },
};
</script>
