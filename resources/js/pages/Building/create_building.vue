<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">Create Building</h2>
    <div class="input-group col-md-6 page_to_page">
      <router-link :to="{ name: 'index_building' }" class="btn btn-primary"
        >All Building</router-link
      >
    </div>
    <div class="row">
      <div class="col-md-12 mx-auto">
        <form @submit.prevent="addProject()">
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label class="hkf_text">Project</label>
            <select class="form-control" v-model="form.project_name" required>
              <option
                v-for="(option, index) in projects"
                :key="index"
                :value="option.project_name"
              >
                {{ option.project_name }}
              </option>
            </select>
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Building Name (Number)</label>
            <input
              type="number"
              class="form-control"
              placeholder="Building Name"
              v-model="form.building_name"
            />
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Average Flat Size</label>
            <input
              type="text"
              class="form-control"
              placeholder="Average Flat Size"
              v-model="form.average_flat_size"
              required
            />
          </div>

          <!-- -->
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Floor Area Size</label>
            <input
              type="text"
              class="form-control"
              placeholder="Floor Area Size"
              v-model="form.floor_area_size"
              required
            />
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Building Height</label>
            <input
              type="text"
              class="form-control"
              placeholder="Building Height"
              v-model="form.building_height"
              required
            />
          </div>
          <div class="form-group mx-sm-3 col-md-6">
            <label for="location" class="hkf_text">Drawing File</label>
            <input
              type="file"
              class="form-control-file col-md-4"
              @change="selectedDocs"
            />
            <embed :src="Supporting_docs" type="application/pdf" />
          </div>
          <!-- -->
          <div class="col-md-6 text-right">
            <button type="submit" class="btn btn-primary mb-2">Save</button>
          </div>
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
  name: "create_building",

  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else if (User.getGuard() == "manager") {
        vm.$router.push({ name: "manager_dashboard" });
      } else {
        vm.$router.push({ name: "create_building" });
      }
    });
  },
  data() {
    return {
      form: {
        project_name: "",
        building_name: "",
        average_flat_size: "",
        floor_area_size: "",
        building_height: "",
        architact_drawing: "",
      },
      Supporting_docs: "",
      projects: [],
      errors: {},
    };
  },
  created() {
    axios
      .get("/api/project")
      .then((res) => {
        this.projects = res.data;
      })
      .catch((err) => {
        console.log(err);
      });
  },
  methods: {
    addProject() {
      const formData = new FormData();
      formData.append("project_name", this.form.project_name);
      formData.append("building_name", this.form.building_name);
      formData.append("average_flat_size", this.form.average_flat_size);
      formData.append("floor_area_size", this.form.floor_area_size);
      formData.append("building_height", this.form.building_height);
      formData.append("architact_drawing", this.form.architact_drawing);

      axios
        .post("/api/building", formData, {
          headers: {
            "Content-Type": "multipart/form-data",
            Accept: "application/json",
          },
        })
        .then((res) => {
          console.log(res.data);
          this.$router.push({ name: "index_building" });
        })
        .catch((err) => console.log(err.response));
    },
  },
  computed: {
    selectedDocs() {
      let file = event.target.files[0];
      let reader = new FileReader();
      reader.onload = (event) => {
        this.Supporting_docs = event.target.result;
        this.form.architact_drawing = file;
      };

      reader.readAsDataURL(file);
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
