<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">Edit Project</h2>
    <div class="input-group col-md-6 page_to_page">
      <router-link :to="{ name: 'all_project' }" class="btn btn-primary"
        >All Project</router-link
      >
    </div>
    <div class="row">
      <div class="col-md-12 mx-auto">
        <form @submit.prevent="updateProject()">
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="projectName" class="hkf_text">Project Name</label>
            <input
              type="text"
              class="form-control"
              placeholder="Project Name"
              v-model="form.project_name"
              required
            />
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Location</label>
            <input
              type="text"
              class="form-control"
              placeholder="Location"
              v-model="form.project_address"
              required
            />
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label class="hkf_text">Status</label>
            <select class="form-control" v-model="form.project_status" required>
              <option
                v-for="(option, index) in options"
                :key="index"
                :value="option.value"
              >
                {{ option.label }}
              </option>
            </select>
          </div>
          <!-- -->
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Contact Number</label>
            <input
              type="text"
              class="form-control"
              placeholder="Contact Number"
              v-model="form.contact_number"
              required
            />
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Land Amount</label>
            <input
              type="text"
              class="form-control"
              placeholder="Land Amount"
              v-model="form.land_amount"
              required
            />
          </div>

        <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Project Code</label>
            <input
              type="text"
              class="form-control"
              placeholder="Project Code"
              v-model="form.project_code"
              required
            />
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Logo</label>
            <input
              type="file"
              class="form-control-file col-md-4"
              @change="nidFileSelected"
            />
            <div class="col-md-4">
              <td>
                <img
                  v-if="!new_logo"
                  :src="'/' + this.logo"
                  alt=""
                  style="width: 50%; height: auto"
                />
                <img
                  v-if="new_logo"
                  :src="this.logo"
                  alt=""
                  style="width: 50%; height: auto"
                />
              </td>
            </div>
          </div>
          <div class="form-group mx-sm-3 col-md-6">
            <label for="location" class="hkf_text">Architact Drawing File</label>
            <input
              type="file"
              class="form-control-file col-md-4"
              @change="selectedDocs"
            />
            <div class="col-md-12 text-right">
              <button type="submit" class="btn btn-primary mb-2">Save</button>
            </div>
            <embed v-if="docs" :src="Supporting_docs" type="application/pdf" />
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
  </div>
</template>
<script>
export default {
  name: "edit_project",
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
        old_project: "",
        project_code:"",
      },
      docs: false,
      new_logo: false,
      Supporting_docs: null,
      options: [
        { value: "in-progress", label: "In Progress" },
        { value: "completed", label: "Completed" },
        { value: "on-hold", label: "On Hold" },
        { value: "upcoming", label: "Upcoming " },
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
        this.form.old_project = data.project_name;
        this.logo = data.logo;
        this.Supporting_docs = data.architact_drawing;
      })
      .catch((err) => {
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
      formData.append("old_project", this.form.old_project);
      formData.append("project_code", this.form.project_code);
      axios
        .post("/api/updateProject", formData,{
	headers:{
	"Content-Type": "multipart/form-data",
"Accept": 'application/json'
}
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
  },
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else if (User.getGuard() == "manager") {
        vm.$router.push({ name: "manager_dashboard" });
      } else {
        vm.$router.push({ name: "edit_project" });
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
