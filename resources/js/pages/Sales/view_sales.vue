<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">View Sales</h2>
    <div class="input-group col-md-6 page_to_page">
      <router-link :to="{ name: 'all_sales' }" class="btn btn-primary"
        >All Sales</router-link
      >
    </div>
    <div class="row">
      <div class="col-md-6 mx-auto">
        <form class="form" @submit.prevent="addSales()">
          <div class="form-group mx-sm-3 mb-2" v-if="isProperty">
            <label class="customLabel">Property Type:</label>
            <span class='hkf_text' v-if="form.property_type !='land'">{{form.property_type}}</span>
             <span class='hkf_text' v-else>Land</span>
          </div>

          <div v-if="isLand">
            <div class="form-group mx-sm-3 mb-2">
              <label for="location" class="customLabel">Location:</label>
              <span class='hkf_text'>{{form.location}}</span>
            </div>
            <div class="form-group mx-sm-3 mb-2">
              <label for="projectName" class="customLabel">Property Name:</label>
              <span class='hkf_text'>{{form.property_name}}</span>
            </div>
            <div class="form-group mx-sm-3 mb-2">
              <label for="projectName" class="customLabel">Katha:</label>
              <span class='hkf_text'>{{form.squareft}}</span>
            </div>
            <div class="form-group mx-sm-3 mb-2">
              <label for="projectName" class="customLabel">Property Amount:</label>
              <span class='hkf_text'>{{form.property_amount}}</span>
            </div>
            <div class="form-group mx-sm-3 mb-2">
              <label for="location" class="customLabel">Property Details:</label>
              <span class='hkf_text'>{{form.property_details}}</span>
            </div>
          </div>
          <div v-if="isBuilding">
            <div class="form-group mx-sm-3 mb-2" v-show="isProject">
              <label class="customLabel">Project:</label>
              <span class='hkf_text'>{{form.property_project}}</span>

            </div>
            <div class="form-group mx-sm-3 mb-2">
              <label for="projectName" class="customLabel">Building Name:</label>
              <span class='hkf_text'>{{form.building_name}}</span>
            </div>
            <div class="form-group mx-sm-3 mb-2">
              <label for="location" class="customLabel">Location:</label>
              <span class='hkf_text'>{{form.location}}</span>

            </div>
            <div class="form-group mx-sm-3 mb-2" v-if="isProperty">
              <label class="customLabel">Label:</label>
              <span class='hkf_text'>{{form.sub_property_type}}</span>

            </div>
            <div class="form-group mx-sm-3 mb-2">
              <label for="projectName" class="customLabel"
                >{{ form.sub_property_type }} Name:</label
              >
              <span class='hkf_text'>{{form.property_name}}</span>
            </div>
            <div class="form-group mx-sm-3 mb-2" v-if="noFloor">
              <label for="location" class="customLabel">Floor Level:</label>
              <span class='hkf_text'>{{form.floor_level}}</span>
            </div>
            <div class="form-group mx-sm-3 mb-2">
              <label for="projectName" class="customLabel"
                >{{ form.sub_property_type }} Amount:</label
              >
              <span class='hkf_text'>{{form.property_amount}}</span>
            </div>
            <div class="form-group mx-sm-3 mb-2">
              <label for="location" class="customLabel"
                >{{ form.sub_property_type }} Size:</label
              >
              <span class='hkf_text'>{{form.size}}</span>
            </div>
          </div>

        </form>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "view_sales",

  data() {
    return {
      property_types: [
        { value: "Building", label: "Building" },
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
      },
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
        this.$router.push({ name: "view_sales" });
      }

    let id = this.$route.params.id;
    axios
      .get("/api/inventory/" + id)
      .then((res) => {
        this.form = res.data;
        if (this.form.property_type == "land") {
          this.isLand = true;
          this.isBuilding = false;
          this.form.sub_property_type = "";
          this.form.building_name = "";
          this.form.size = "";
          this.isProject = false;
        } else if(this.form.property_type == "Building"){
          this.isBuilding = true;
          this.isLand = false;
          this.form.squareft = "";
          this.isProject = true;
          axios
          .get("/api/project")
          .then((res) => {
            this.projects = res.data;
          })
          .catch((err) => {
            console.log(err.response);
          });

        }
      })
      .catch((err) => {
        console.log(err.response);
      });
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
              .patch("/api/inventory"+this.$route.params.id, this.form, {
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
        axios
          .get("/api/project")
          .then((res) => {
            this.projects = res.data;
          })
          .catch((err) => {
            console.log(err.response);
          });
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
        if (project.project_name == this.form.property_project) {
          this.form.location = project.project_address;
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

.customLabel{
color:#605ca8 ;
font-size:1.2em;
font-weight:bold;
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
