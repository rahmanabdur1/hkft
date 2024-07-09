<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">View Building</h2>
    <div class="input-group col-md-6 page_to_page">
      <router-link :to="{ name: 'index_building' }" class="btn btn-primary"
        >All Building</router-link
      >
    </div>
    <div class="row">
      <div class="col-md-12 mx-auto">
        <form>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="projectName" class="hkf_text">Project Name:</label>
            <label class="hkf_text">{{ form.project_name }}</label>
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Building Name:</label>
            <label class="hkf_text">{{ form.building_name }}</label>
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label class="hkf_text">Average Flat Size:</label>
            <label class="hkf_text">{{ form.average_flat_size }}</label>
          </div>
          <!-- -->
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Floor Area Size:</label>
            <label class="hkf_text">{{ form.floor_area_size }}</label>
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Building Height:</label>
            <label class="hkf_text">{{ form.building_height }}</label>
          </div>
          <div class="form-group mx-sm-3 col-md-6" v-if="form.architact_drawing != ''">
            <label for="location" class="hkf_text">Drawing File:</label>
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
    <div class="mt-5" v-if="existStage">
      <table
        class="table custom_table"
        style="
          width: 100%;
          border: 1px solid black;
          border-collapse: collapse;
          text-align: center;
        "
      >
        <thead>
          <th>Sl</th>
          <th>Date</th>
          <th>Stage</th>
          <th>Action</th>
        </thead>

        <tbody>
          <tr v-for="(stage, index) in stages" :key="index">
            <td style="border: 1px solid black">
              {{ index + 1 }}
            </td>
            <td style="border: 1px solid black">
              {{ stage.stage_date }}
            </td>
            <td style="border: 1px solid black">
              {{ stage.stage }}
            </td>
            <td style="border: 1px solid black">
              <router-link
                :to="{ name: 'edit_stage', params: { id: stage.id } }"
                class="btn btn-primary"
                >Edit Stage</router-link
              >
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>
<script>
export default {
  name: "view_building",
  data() {
    return {
      logo: "",
      form: {
        project_name: "",
        building_name: "",
        average_flat_size: "",
        floor_area_size: "",
        building_height: "",
      },
      Supporting_docs: "",
      existStage: false,
      stages: [],
      docs: false,
      new_logo: false,
      Supporting_docs: null,
      existStage: false,
      options: [
        { value: "in-progress", label: "In Progress" },
        { value: "completed", label: "Completed" },
        { value: "on-hold", label: "On Hold" },
      ],
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
    axios
      .get("/api/building/" + this.$route.params.id)
      .then((res) => {
        this.form = res.data;
        this.Supporting_docs = "/" + res.data.architact_drawing;
        console.log(res.data);
      })
      .catch((err) => {
        console.log(err.response);
      });
    axios
      .get("/api/project_stage/" + this.$route.params.id)
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

  beforeRouteEnter(to, from, next) {
    next((vm) => {
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else if (User.getGuard() == "manager") {
        vm.$router.push({ name: "manager_dashboard" });
      } else {
        vm.$router.push({ name: "view_building" });
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
