<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">View Project</h2>
    <div class="input-group col-md-6 page_to_page">
      <router-link :to="{ name: 'all_project' }" class="btn btn-primary"
        >All Project</router-link
      >
    </div>
    <div class="row">
      <div class="col-md-12 mx-auto">
        <form @submit.prevent="updateProject()">
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="projectName" class="hkf_text">Project Name:</label>
            <label class="hkf_text">{{ form.project_name }}</label>
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Location:</label>
            <label class="hkf_text">{{ form.project_address }}</label>
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label class="hkf_text">Status:</label>
            <label class="hkf_text">{{ form.project_status }}</label>
          </div>
          <!-- -->
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Contact Number:</label>
            <label class="hkf_text">{{ form.contact_number }}</label>
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Land Amount:</label>
            <label class="hkf_text">{{ form.land_amount }}</label>
          </div>

          <div class="form-group mx-sm-3 col-md-6 mb-2" v-if="form.logo != ''">
            <label for="location" class="hkf_text">Logo</label>

            <div class="col-md-4">
              <td>
                <img
                  v-if="!new_logo"
                  :src="'/' + this.logo"
                  alt=""
                  style="width: 50%; height: auto"
                />
              </td>
            </div>
          </div>
          <div class="form-group mx-sm-3 col-md-6" v-if="form.architact_drawing != ''">
            <label for="location" class="hkf_text">Architact Drawing File:</label>
            <!-- <button
              type="button"
              class="btn action mt-2"
              @click="PrintContent5"
              style="width: 100px"
            >
              Print <i class="fa fa-print pl-2" aria-hidden="true"></i>
            </button> -->
            <a :href="Supporting_docs" target="_blank" rel="noopener noreferrer">
              <button type="button" class="btn action mt-2" style="width: 100px">
                Print
                <i class="fa fa-download pl-2" aria-hidden="true"></i>
                <i class="fa fa-print pl-2" aria-hidden="true"></i>
              </button>
            </a>

            <!-- <embed v-if="docs" :src="Supporting_docs" type="application/pdf" /> -->
          </div>

          <!-- -->
        </form>
        <small class="text text-danger" v-if="errors.project_name">{{
          errors.project_name[0]
        }}</small>
        <small class="text text-danger" v-if="errors.project_address">{{
          errors.project_address[0]
        }}</small>
      </div>
    </div>
    <div class="input-group col-md-6 page_to_page">
      <router-link
        :to="{ name: 'add_stage', params: { id: this.$route.params.id } }"
        class="btn btn-primary"
        >Add Stage</router-link
      >
    </div>
  </div>
</template>
<script>
export default {
  name: "view_project",
  data() {
    return {
      logo: "",
      form: {
        project_name: "",
        project_address: "",
        project_status: "",
        logo: "",
        contact_number: "",
        land_amount: "",
        average_flat_size: "",
        flore_area_size: "",
        building_height: "",
        architact_drawing: "",
      },
      existStage: false,
      stages: [],
      docs: false,
      new_logo: false,
      Supporting_docs: null,
      options: [
        { value: "in-progress", label: "In Progress" },
        { value: "completed", label: "Completed" },
        { value: "on-hold", label: "On Hold" },
      ],
      errors: {},
    };
  },
  created() {
    let id = this.$route.params.id;
    axios
      .get("/api/project/" + id)
      .then(({ data }) => {
        this.form = data;
        this.logo = data.logo;
        console.log(data);
        this.Supporting_docs = "/" + data.architact_drawing;
        if (this.Supporting_docs != "") {
          this.docs = true;
        }
      })
      .catch((err) => {});

    axios
      .get("/api/project_stage/" + id)
      .then((res) => {
        this.stages = res.data;
        if (this.stages != "") {
          this.existStage = true;
        }
      })
      .catch((err) => {
        cosnsole.log(err.response);
      });
  },
  methods: {
    updateProject() {
      let id = this.$route.params.id;
      const formData = new FormData();
      formData.append("id", id);
      formData.append("project_name", this.form.project_name);
      formData.append("project_address", this.form.project_address);
      formData.append("project_status", this.form.project_status);
      formData.append("logo", this.form.logo);
      formData.append("contact_number", this.form.contact_number);
      formData.append("land_amount", this.form.land_amount);
      formData.append("average_flat_size", this.form.average_flat_size);
      formData.append("flore_area_size", this.form.flore_area_size);
      formData.append("building_height", this.form.building_height);
      formData.append("architact_drawing", this.form.architact_drawing);

      axios
        .post("/api/updateProject", formData, {
          headers: {
            "Content-Type": "multipart/form-data",
          },
        })
        .then((res) => {
          this.$router.push({ name: "all_project" });
        })
        .catch((err) => {
          this.errors = err.response.data;
        });
    },
    nidFileSelected(event) {
      let file = event.target.files[0];
      let reader = new FileReader();
      reader.onload = (event) => {
        this.new_logo = true;
        if (this.new_logo) {
          this.logo = event.target.result;
        }
        this.form.logo = file;
      };
      reader.readAsDataURL(file);
    },
    selectedDocs() {
      this.docs = true;
      let file = event.target.files[0];
      let reader = new FileReader();
      reader.onload = (event) => {
        this.Supporting_docs = event.target.result;
        this.form.architact_drawing = file;
      };

      reader.readAsDataURL(file);
    },
    PrintContent5() {
      const file = "../" + this.form.architact_drawing;
      const newWindow = window.open(file);
      newWindow.onload = () => {
        newWindow.print();
        // newWindow.close();
        /* if (newWindow.close()) {
          this.$router.push({
            name: "view_project",
            params: { id: this.$route.params.id },
          });
        } */
      };
    },
  },
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else if (User.getGuard() == "manager") {
        vm.$router.push({ name: "manager_dashboard" });
      } else {
        vm.$router.push({ name: "view_project" });
      }
    });
  },
};
</script>

<style>
.hkf_title {
  color: #605ca8 !important;
  border-bottom: 1px solid #554e6a;
}
.hkf_texts {
  color: #605ca8 !important;
  font-weight: bold;
}
</style>
