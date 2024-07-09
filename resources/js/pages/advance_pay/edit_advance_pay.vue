<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">Edit Extra Payment</h2>
    <div class="input-group col-md-6 page_to_page">
      <router-link :to="{ name: 'all_advance_pay' }" class="btn btn-primary"
        >Extra Pay Lists</router-link
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
            <label for="projectName" class="hkf_text"
              >Client ID :{{ form.client_id }}</label
            >

            <input
              type="text"
              class="form-control status"
              placeholder="Client ID"
              v-model="client_search"
              @keyup="listDisplay"
            />
            <ul class="ulShow" :class="{ listStyle: list_style }">
              <li
                class="listShow"
                :class="{ listStyle: list_style }"
                v-for="(item, index) in filterClient"
                :key="index"
                :value="item.client_id"
                @click="assignToSearch(item)"
              >
                {{ item.client_id }}
              </li>
            </ul>
          </div>
          <div class="form-group col-md-4 mx-sm-3 mb-2">
            <label for="projectName" class="hkf_text"
              >Select Project :{{ form.selectedProject }}</label
            >
            <select
              class="form-control status"
              id="status"
              v-model="form.selectedProject"
              onfocus="this.size=10"
              onblur="this.size=1"
              onchange="this.size=1;this.blur();"
              @change="chooseProject"
              required
            >
              <option
                v-for="(project, index) in projects"
                :key="index"
                :value="project.clientUnderProject"
              >
                {{ project.clientUnderProject }}
              </option>
            </select>
          </div>
          <div class="form-group col-md-4 mx-sm-3 mb-2">
            <label for="projectName" class="hkf_text"
              >Select Building :{{ form.selectedBuilding }}</label
            >
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
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Amount</label>
            <input
              type="text"
              class="form-control"
              placeholder="Amount"
              v-model="form.amount"
              required
            />
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Note</label>
            <input
              type="text"
              class="form-control"
              placeholder="Note"
              v-model="form.note"
            />
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
      } else if (User.getGuard() == "manager") {
        vm.$router.push({ name: "manager_dashboard" });
      } else {
        vm.$router.push({ name: "edit_advance_pay" });
      }
    });
  },
  data() {
    return {
      logo: "",
      isBuilding: false,
      projects: [],
      buildings: [],
      allClients: [],
      client_nid: "",
      list_style: true,
      client_search: "",
      form: {
        selectedProject: "",
        selectedBuilding: "",
        amount: "",
        note: "",
        client_name: "",
        basic_date: "",
        client_id: "",
        old_amount: "",
      },
    };
  },
  created() {
    axios.get("/api/client").then((res) => {
      this.allClients = res.data;
    });
    axios
      .get("/api/advance_pay/" + this.$route.params.id)
      .then((res) => {
        this.form = res.data;
        this.form.old_amount = res.data.amount;
      })
      .catch((err) => {
        console.log(err.response);
      });
  },
  methods: {
    listDisplay() {
      this.list_style = false;
    },
    assignToSearch(item) {
      this.client_search = item.client_id;
      this.list_style = true;
      axios
        .get("/api/fetch_client_project/" + item.client_id)
        .then((res) => {
          this.projects = res.data;
        })
        .catch((err) => {});
      this.isBuilding = true;
      axios
        .get("/api/fetchBuildingFromProjectInventories/" + this.form.selectedProject)
        .then((res) => {
          this.buildings = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });
      this.form.client_name = item.name;
      this.form.client_id = item.client_id;
    },
    addProject() {
      axios
        .patch("/api/advance_pay/" + this.$route.params.id, this.form, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.$router.push({ name: "all_advance_pay" });
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
  },
  computed: {
    chooseProject() {
      this.isBuilding = true;
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
        let productLedger = product.client_id.toUpperCase();
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
