<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">Construction Cost</h2>
    <div class="input-group col-md-6 page_to_page">
      <router-link :to="{ name: 'all_required_construction' }" class="btn btn-primary"
        >All Construction Cost</router-link
      >
    </div>
    <div class="row">
      <div class="col-md-12 mx-auto">
        <form @submit.prevent="addProject()">
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="projectName" class="hkf_text">Date</label>
            <input type="date" class="form-control" v-model="form.basic_date" required />
          </div>
          <div class="form-group col-md-4 mx-sm-3 mb-2" v-if="admin">
            <label for="projectName" class="hkf_text">Select Project</label>
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
                :value="project.project_name"
              >
                {{ project.project_name }}
              </option>
            </select>
          </div>
          <div class="form-group col-md-4 mx-sm-3 mb-2" v-if="manager">
            <label for="projectName" class="hkf_text">Select Project</label>
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
                v-for="(project, index) in allProjects"
                :key="index"
                :value="project.project"
              >
                {{ project.project }}
              </option>
            </select>
          </div>
          <div class="form-group col-md-4 mx-sm-3 mb-2">
            <label for="projectName" class="hkf_text">Select Building</label>
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
            <label for="projectName" class="hkf_text"
              >Client Name : {{ form.client_name }}</label
            >

            <input
              type="text"
              class="form-control status"
              placeholder="Client Name"
              v-model="client_search"
              @keyup="listDisplay"
              required
            />
            <ul class="ulShow" :class="{ listStyle: list_style }">
              <li
                class="listShow"
                :class="{ listStyle: list_style }"
                v-for="(item, index) in filterClient"
                :key="index"
                :value="item.name"
                @click="assignToSearch(item)"
              >
                {{ item.name }}
              </li>
            </ul>
          </div>

          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Required Amount</label>
            <input
              type="text"
              class="form-control"
              placeholder="Amount"
              v-model="form.required_amount"
              required
            />
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label class="hkf_text">Due Date</label>
            <input type="date" class="form-control" v-model="form.due_date" />
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Purpose/Note</label>
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
      } else {
        vm.$router.push({ name: "edit_required_construction" });
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

      form: {
        due_date: "",
        selectedProject: "",
        selectedBuilding: "",
        required_amount: "",
        note: "",
        client_name: "",
        basic_date: "",
        client_id: "",
        all_client: "",
        clients: [],
        share: "",
      },
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
    let id = this.$route.params.id;
    axios
      .get("/api/construction/" + id)
      .then((res) => {
        this.form = res.data;
        this.client_search = res.data.client_name;
        axios
          .get("/api/fetchBuildingFromProjectInventories/" + this.form.selectedProject)
          .then((res) => {
            this.buildings = res.data;
          })
          .catch((err) => {
            console.log(err.response);
          });
        axios
          .get("/api/fetchClientByProject/" + this.form.selectedProject)
          .then((res) => {
            this.allClients = res.data;
          })
          .catch((err) => {
            console.log(err.response);
          });
      })
      .catch((err) => {
        console.log(err.response);
      });
  },
  methods: {
    calculate() {
      this.form.required_amount =
        parseInt(this.form.required_amount) * parseInt(this.form.share);
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
        .patch("/api/construction/" + this.$route.params.id, this.form, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.$router.push({ name: "all_required_construction" });
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
  },
  computed: {
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
