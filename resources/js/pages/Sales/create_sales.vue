<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">Create Sales</h2>
    <div class="input-group col-md-6 page_to_page">
      <router-link :to="{ name: 'all_sales' }" class="btn btn-primary"
        >All Sales</router-link
      >
    </div>
    <div class="row">
      <div class="col-md-6 mx-auto">
        <form class="form" @submit.prevent="addSales()">
          <div class="form-group mx-sm-3 mb-2" v-if="isProperty">
            <label class="hkf_text">Property Type</label>
            <select
              class="form-control"
              id="status"
              name="status"
              v-model="form.property_type"
              @change="chooseProperty"
              required
            >
              <option
                v-for="(property_type, index) in property_types"
                :key="index"
                :value="property_type.value"
              >
                {{ property_type.label }}
              </option>
            </select>
          </div>


          <div v-if="isLand">
            <div class="form-group mx-sm-3 mb-2" >
              <label for="location" class="hkf_text">Location</label>
              <input
                type="text"
                class="form-control"
                placeholder="Location"
                v-model="form.location"

              />
            </div>
            <div class="form-group mx-sm-3 mb-2">
              <label for="projectName" class="hkf_text">Property Name</label>
              <input
                type="text"
                class="form-control"
                placeholder="Property Name"
                required
                v-model="form.property_name"
              />
            </div>
            <div class="form-group mx-sm-3 mb-2">
              <label for="projectName" class="hkf_text">Katha</label>
              <input
                type="text"
                class="form-control"
                placeholder="Katha"
                required
                v-model="form.squareft"
              />
            </div>
             <div class="form-group mx-sm-3 mb-2" >
              <label for="location" class="hkf_text">Daag No</label>
              <input
                type="text"
                class="form-control"
                placeholder="Daag No"
                v-model="form.daag_no"

              />
            </div>
            <div class="form-group mx-sm-3 mb-2">
              <label for="projectName" class="hkf_text">Property Amount</label>
              <input
                type="text"
                class="form-control"
                placeholder="Property Amount"
                v-model="form.property_amount"
                required
              />
            </div>

            <div class="form-group mx-sm-3 mb-2">
              <label for="location" class="hkf_text">Property Details</label>
              <input
                type="text"
                class="form-control"
                placeholder="Details"
                v-model="form.property_details"
              />
            </div>
          </div>
          <div v-if="isBuilding">
           <div class="form-group mx-sm-3 mb-2" v-if='admin' v-show="isProject">
            <label class="hkf_text">Project</label>
            <select
              class="form-control"
              id="status"
              v-model="form.property_project"
              @change="chooseProject"
              required
              onfocus="this.size=8"
              onblur="this.size=1"
              onchange="this.size=1;this.blur();"
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
           <div class="form-group mx-sm-3 mb-2" v-if='manager' v-show="isProject">
            <label class="hkf_text">Project</label>
            <select
              class="form-control"
              id="status"
              v-model="form.property_project"
              @change="chooseProject"
              required
              onfocus="this.size=8"
              onblur="this.size=1"
              onchange="this.size=1;this.blur();"
            >
              <option
                v-for="(project, index) in projects"
                :key="index"
                :value="project.project"
              >
                {{ project.project }}
              </option>
            </select>
          </div>
            <div class="form-group mx-sm-3 mb-2">
              <label for="projectName" class="hkf_text">Building Name</label>
              <input
                type="text"
                class="form-control"
                place="building name..."
                required
                v-model="form.building_name"
              />
            </div>
            <div class="form-group mx-sm-3 mb-2">
              <label for="location" class="hkf_text">Location</label>
              <input
                type="text"
                class="form-control"
                placeholder="Location"
                v-model="form.location"
                disabled
              />
            </div>
            <div class="form-group mx-sm-3 mb-2" v-if="isProperty">
              <label class="hkf_text">Label</label>
              <select
                class="form-control"
                id="status"
                name="status"
                v-model="form.sub_property_type"
                @change="checkFloor"
                required
              >
                <option
                  v-for="(sub_property_type, index) in sub_property_types"
                  :key="index"
                  :value="sub_property_type.value"
                >
                  {{ sub_property_type.label }}
                </option>
              </select>
            </div>
            <div class="form-group mx-sm-3 mb-2">
              <label for="projectName" class="hkf_text"
                >{{ form.sub_property_type }} Name</label
              >
              <input
                type="text"
                class="form-control"
                required
                v-model="form.property_name"
              />
            </div>
            <div class="form-group mx-sm-3 mb-2" v-if="noFloor">
              <label for="location" class="hkf_text">Floor Level</label>
              <input
                type="text"
                class="form-control"
                placeholder="Floor Level"
                v-model="form.floor_level"
              />
            </div>
            <div class="form-group mx-sm-3 mb-2">
              <label for="projectName" class="hkf_text"
                >{{ form.sub_property_type }} Amount</label
              >
              <input
                type="text"
                class="form-control"
                required
                v-model="form.property_amount"
              />
            </div>
            <div class="form-group mx-sm-3 mb-2">
              <label for="location" class="hkf_text"
                >{{ form.sub_property_type }} Size</label
              >
              <input type="text" class="form-control" v-model="form.size" />
            </div>
          </div>
          <div style="width: 100%; text-align: right">
            <button type="submit" class="btn btn-primary mb-2">Save</button>
          </div>
          <span class="text-danger" v-if="exist">{{ exist }}</span>
        </form>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "create_sales",

  data() {
    return {
      property_types: [
      
        { value: "land", label: "Land" },
      ],
      sub_property_type: [],
      isBuilding: false,
      isLand: false,
      form: {
        property_name: "",
        location: "",
        property_project: "",
        property_amount: "",
        property_type: "",
        sub_property_type: "",
        property_id: "",
        squareft: "",
        property_status: "Available",
        property_details: "",
        floor_level: "",
        size: "",
        building_name: "",
        daag_no:"",
        sub_property_id:"",
      },
      admin:false,
      manager:false,
      isProject: false,
      noFloor: false,
      projects: [],
      isProperty: true,
      sub_property_types: [
        { value: "floor", label: "Floor" },
        { value: "flat", label: "Flat" },
        { value: "shop", label: "Shop" },
      ],
      errors: {},
      exist: "",
    };
  },
  created() {
    if (!User.hasLoggedIn()) {
       this.$router.push({ name: "home" });
      }  else {
        this.$router.push({ name: "create_sales" });
      }
  },
  methods: {
    addSales() {
      //check property id

      axios
        .post("/api/checkPropertyId", this.form, {
                  headers: {
                   "Content-Type": "application/json",
                    "Accept": "application/json",
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
            axios
              .post("/api/inventory", this.form, {
                  headers: {
                   "Content-Type": "application/json",
                    "Accept": "application/json",
                  },
                })
              .then((res) => {
                if (!res.data.exist) {
                  this.$router.push({ name: "all_sales" });
                } else {
                  this.exist = res.data.exist;
                }
              })
              .catch((error) => {
                this.errors = error.response;
              });
          } else if ($property_id != null && $property_id != undefined) {
            this.form.property_id = $property_id;
            axios
              .post("/api/inventory", this.form, {
                  headers: {
                   "Content-Type": "application/json",
                    "Accept": "application/json",
                  },
                })
              .then((res) => {
                if (!res.data.exist) {
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
    if(this.guard =='admin'){
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
    }else if(this.guard =='manager'){
        this.manager = true;
        this.admin=false;
        this.manager_username = User.getUserName();
        axios.get('/api/getManagerProject/'+this.manager_username).then((res)=>{
            this.projects = res.data;
            console.log(this.projects);
        }).catch((err)=>{
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
      this.projects.forEach((project) => {
       if(User.getGuard()=='admin'){
         if (project.project_name == this.form.property_project) {

          this.form.location = project.project_address;
        }
       }else if(User.getGuard()=='manager'){

         if (project.project == this.form.property_project) {
          axios.get('/api/fetch_project/'+project.project).then((res)=>{

           this.form.location =res.data.project_address;

          })
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
