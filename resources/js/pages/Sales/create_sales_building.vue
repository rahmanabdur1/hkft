<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">Create Sales</h2>
    <div class="input-group col-md-6 page_to_page">
      <router-link :to="{ name: 'all_sales' }" class="btn btn-primary"
        >All Sales</router-link
      >
    </div>
    <div class="row">
      <div class="col-md-12 mx-auto">
        <form class="form" @submit.prevent="addSales()">
          <div style="display: flex">
            <div class="form-group col-md-3 mx-sm-3 mb-2">
              <label for="projectName" class="hkf_text">Select Project</label>
              <select
                class="form-control status"
                id="status"
                v-model="form.property_project"
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
            <div class="form-group col-md-2 mx-sm-3 mb-2">
              <label for="projectName" class="hkf_text">Select Building</label>
              <select
                class="form-control status"
                id="status"
                v-model="form.selectedBuilding"
                onfocus="this.size=10"
                onblur="this.size=1"
                onchange="this.size=1;this.blur();"
                @change="chooseProject"
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
            <div class="form-group col-md-2 mx-sm-3 mb-2">
              <label for="projectName" class="hkf_text">Floor</label>
              <input type="number" class="form-control" required v-model="form.floor" />
            </div>
          </div>
          <div class="form-group col-md-1 mx-sm-3 mb-2">
            <label for="projectName" class="hkf_text">Flat</label>
            <p class="btn" @click="addFlat()">
              <i
                class="fa fa-plus"
                style="
                  border-radius: 50%;
                  border: 2px solid #605ca8;
                  padding: 0.25em;
                  color: #605ca8;
                "
              ></i>
            </p>
          </div>
          <div>
            <div class="flat col-md-12">
              <!-- Dynamically render input fields using v-for -->
              <div
                v-for="(value, index) in form.flat"
                :key="index"
                class="input-wrapper"
                style="display: flex; padding: 0.3em"
              >
                <input
                  type="text"
                  class="form-control col-md-3 mr-2"
                  placeholder="a/b/c/d/e..."
                  v-model="form.flat[index]"
                  required
                />
                <input
                  type="text"
                  class="form-control mr-2"
                  placeholder="Details.."
                  col-md-5
                  v-model="form.property_details[index]"
                />
                <input
                  type="text"
                  class="form-control"
                  placeholder="Flat Size.."
                  v-model="form.flat_size[index]"
                />
                <i class="fa fa-trash ml-2" @click="removeFlat(index)"></i>
              </div>
            </div>
          </div>
          <div style="width: 100%; text-align: right">
            <button type="submit" class="btn btn-primary mb-2">Save</button>
          </div>
          <span class="text-danger" v-if="exist">{{ exist }}</span>
          <span class="text-danger font-weight-bold ml-4">{{ error }}</span>
        </form>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "create_sales_building",

  data() {
    return {
      form: {
        selectedBuilding: "",
        property_project: "",
        floor: "",
        flat: [],
        property_details: [],
        flat_size: [],
        property_type: "",
        property_id: "",
        sub_property_type: "",
        sub_property_id: "",
        location: "",
        property_amount: 0,
      },
      error: "",
      count: 0,
      admin: false,
      manager: false,
      buildings: [],
      projects: [],
      errors: {},
      exist: "",
    };
  },
  created() {
    if (!User.hasLoggedIn()) {
      this.$router.push({ name: "home" });
    } else {
      this.$router.push({ name: "create_sales_building" });
    }
    if (User.getGuard() == "admin") {
      axios.get("/api/project").then((res) => {
        this.projects = res.data;
      });
    } else if (User.getGuard() == "manager") {
      this.manager_username = User.getUserName();
      axios
        .get("/api/getManagerProject/" + this.manager_username)
        .then((res) => {
          this.projects = res.data;
          console.log(this.projects);
        })
        .catch((err) => {
          console.log(err.response);
        });
    }
  },
  methods: {
    addFlat() {
      this.form.flat.push(""); // Add an empty string to the flat array
      this.form.property_details.push("");
      this.form.flat_size.push("");
    },
    addProperty() {
      document.querySelector(".customModal1").style.display = "block";
    },
    removeFlat(index) {
      this.form.flat.splice(index, 1); // Remove the flat value at the specified index
    },
    addSales() {
      //check property id

      axios
        .post("/api/checkPropertyId", this.form, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          let $property_id;
          $property_id = res.data.property_id;
          const alphabet = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz";
          let randomString = "";
          for (let i = 0; i < 5; i++) {
            const randomIndex = Math.floor(Math.random() * alphabet.length);
            const randomLetter = alphabet.charAt(randomIndex);
            randomString += randomLetter;
          }
          const uniqueId = randomString + "-" + Math.floor(Math.random() * 999999);

          this.form.sub_property_id = uniqueId;
          if (!$property_id) {
            const alphabet = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz";
            let randomString = "";
            for (let i = 0; i < 5; i++) {
              const randomIndex = Math.floor(Math.random() * alphabet.length);
              const randomLetter = alphabet.charAt(randomIndex);
              randomString += randomLetter;
            }
            const uniqueId = randomString + "-" + Math.floor(Math.random() * 999999);

            this.form.property_id = uniqueId;
            let length = this.form.flat.length;
            if (length > 0) {
              axios
                .post("/api/inventory/building", this.form, {
                  headers: {
                    "Content-Type": "application/json",
                    Accept: "application/json",
                  },
                })
                .then((res) => {
                  if (!res.data.exist) {
                    console.log(res.data);
                    this.$router.push({ name: "all_sales" });
                  } else {
                    this.exist = res.data.exist;
                  }
                })
                .catch((error) => {
                  this.errors = error.response;
                });
            } else {
              this.error = "Create Flat Name";
            }
          } else if ($property_id != null && $property_id != undefined) {
            this.form.property_id = $property_id;
            axios
              .post("/api/inventory", this.form, {
                headers: {
                  "Content-Type": "application/json",
                  Accept: "application/json",
                },
              })
              .then((res) => {
                if (!res.data.exist) {
                  console.log(res.data);
                  this.$router.push({ name: "all_sales" });
                } else {
                  this.exist = res.data.exist;
                }
              })
              .catch((error) => {
                this.errors = error.response;
                console.log(error.response);
              });
          }
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    closePopUp() {
      document.querySelector(".customModal1").style.display = "none";
    },
  },
  computed: {
    chooseProperty() {
      if (this.form.property_type == "Building") {
        this.isBuilding = true;
        this.isLand = false;
        this.form.squareft = "";
        this.isProject = true;
        //

        //admin  & manager
        this.guard = User.getGuard();
        if (this.guard == "admin") {
          this.admin = true;
          this.manager = false;
          axios
            .get("/api/project")
            .then(({ data }) => {
              this.projects = data;
            })
            .catch((err) => {
              this.errors = err.response.data;
            });
        } else if (this.guard == "manager") {
          this.manager = true;
          this.admin = false;
          this.manager_username = User.getUserName();
          axios
            .get("/api/getManagerProject/" + this.manager_username)
            .then((res) => {
              this.projects = res.data;
              console.log(this.projects);
            })
            .catch((err) => {
              console.log(err.response);
            });
        }
        //end
      } else if (this.form.property_type == "land") {
        this.isLand = true;
        this.isBuilding = false;
        this.form.sub_property_type = "";
        this.form.building_name = "";
        this.form.size = "";
        this.isProject = false;
      }
    },
    chooseProject() {
      axios
        .get("/api/fetchBuildingInventory/" + this.form.property_project)
        .then((res) => {
          this.buildings = res.data;
          console.log(this.buildings);
        })
        .catch((err) => {
          console.log(err.response);
        });
      this.projects.forEach((project) => {
        if (User.getGuard() == "admin") {
          if (project.project_name == this.form.property_project) {
            this.form.location = project.project_address;
          }
        } else if (User.getGuard() == "manager") {
          if (project.project == this.form.property_project) {
            axios.get("/api/fetch_project/" + project.project).then((res) => {
              this.form.location = res.data.project_address;
            });
          }
        }
      });
    },
    checkFloor() {
      if (this.form.sub_property_type == "floor") {
        this.noFloor = false;
      } else {
        this.noFloor = true;
      }
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
