<template>
  <div class="row">
    <div class="col-md-12 mx-auto">
      <h2 class="text-center mb-4 hkf_title">Edit Client</h2>
      <div class="row">
        <div class="col-md-10 mx-auto">
          <form @submit.prevent="addClient()">
            <div class="form-group row">
              <label class="col-sm-2 col-form-label hkf_text" style="font-size: 1.2em"
                >Select Project</label
              >
              <div class="col-sm-8">
                <select
                  class="form-control"
                  id="status"
                  v-model="form.clientUnderProject"
                  @change="checkOption"
                  required
                >
                  <option
                    v-for="(project, index) in projects"
                    :value="project.value"
                    :key="index"
                  >
                    {{ project.project_name }}
                  </option>
                </select>
              </div>
            </div>
            <div>
              <div class="form-group row" v-if="isBuilding">
                <label
                  for="projectName"
                  class="col-sm-2 col-form-label hkf_text"
                  style="font-size: 1.2em"
                  >Select Building</label
                >
                <div class="col-md-8">
                  <select
                    class="form-control status"
                    id="status"
                    v-model="form.selectedBuilding"
                    onfocus="this.size=10"
                    onblur="this.size=1"
                    onchange="this.size=1;this.blur();"
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
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">নাম</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control"
                    id="status"
                    v-model="form.name"
                    required
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">পিতার নাম</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control"
                    id="status"
                    v-model="form.father_name"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">মাতার নাম</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control"
                    id="status"
                    v-model="form.mother_name"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">স্বামি/স্ত্রীর নাম</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control"
                    id="status"
                    v-model="form.husban_wife_name"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">জন্ম তারিখ</label>
                <div class="col-sm-8">
                  <input
                    type="date"
                    class="form-control"
                    id="status"
                    v-model="form.birth_date"
                  />
                  <small class="text text-danger" v-if="errors.birth_date">{{
                    errors.birth_date[0]
                  }}</small>
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">ধর্ম</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control"
                    id="status"
                    v-model="form.religion"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">পেশা</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control"
                    id="status"
                    v-model="form.occupation"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">জাতীয়তা</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control"
                    id="status"
                    v-model="form.nationality"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">জাতীয় আইডি নং</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control"
                    id="status"
                    v-model="form.national_id_no"
                  />
                </div>
              </div>

              <div class="row">
                <label class="col-sm-8 col-form-label thikana" style="color: black"
                  >স্থায়ী ঠিকানা</label
                >
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">গ্রাম/রোড</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control"
                    id="status"
                    v-model="form.permanent_location"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">ডাকঘর</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control"
                    id="status"
                    v-model="form.permanent_post_office"
                  />
                </div>
              </div>

              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">থানা/উপজেলা</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control"
                    id="status"
                    v-model="form.permanent_thana"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">জেলা</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control"
                    id="status"
                    v-model="form.permanent_district"
                  />
                </div>
              </div>

              <div class="row">
                <label class="col-sm-8 col-form-label thikana" style="color: black"
                  >বর্তমান ঠিকানা</label
                >
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">গ্রাম/রোড</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control"
                    id="status"
                    v-model="form.temprorary_location"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">ডাকঘর</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control"
                    id="status"
                    v-model="form.temprorary_post_office"
                  />
                </div>
              </div>

              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">থানা/উপজেলা</label>
                <div class="col-sm-6">
                  <input
                    type="text"
                    class="form-control"
                    id="status"
                    v-model="form.temprorary_thana"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">জেলা</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control"
                    id="status"
                    v-model="form.temprorary_district"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">টি. আই. এন</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control"
                    id="status"
                    v-model="form.tin"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">মোবাইল নাম্বার</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control"
                    id="status"
                    v-model="form.phone"
                    required
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">ইমেল আইডি</label>
                <div class="col-sm-8">
                  <input
                    type="email"
                    class="form-control"
                    id="status"
                    v-model="form.email"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">শেয়ার</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control"
                    id="status"
                    v-model="form.share"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-3 col-form-label hkf_text">
                  জাতীয় পরিচয়পত্রের ফটোকপি</label
                >
                <div class="col-sm-3">
                  <input
                    type="file"
                    class="form-control-file"
                    id="exampleFormControlFile1"
                    @change="nidFileSelected"
                  />
                </div>
                <div class="col-md-4">
                  <td>
                    <img
                      v-if="clickOnChooseNid"
                      :src="new_nid_img"
                      alt=""
                      style="width: 50%; height: auto"
                    />
                    <img
                      v-else
                      :src="'/' + form.nid_img"
                      style="width: 50%; height: auto"
                    />
                  </td>
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-3 col-form-label hkf_text">পাসপোর্টের ফটোকপি</label>
                <div class="col-sm-3">
                  <input
                    type="file"
                    class="form-control-file"
                    id="exampleFormControlFile1"
                    @change="passportFileSelected"
                  />
                </div>
                <div class="col-md-4">
                  <td>
                    <img
                      v-if="clickOnChoosePassport"
                      :src="new_passport_img"
                      alt=""
                      style="width: 50%; height: auto"
                    />
                    <img
                      v-else
                      :src="'/' + form.passport_img"
                      style="width: 50%; height: auto"
                    />
                  </td>
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-3 col-form-label hkf_text">টি. আই. এন ফটোকপি</label>
                <div class="col-sm-3">
                  <input
                    type="file"
                    class="form-control-file"
                    id="exampleFormControlFile1"
                    @change="tinFileSelected"
                  />
                </div>
                <div class="col-md-4">
                  <td>
                    <img
                      v-if="clickOnChooseTin"
                      :src="new_tin_img"
                      alt=""
                      style="width: 50%; height: auto"
                    />
                    <img
                      v-else
                      :src="'/' + form.tin_img"
                      style="width: 50%; height: auto"
                    />
                  </td>
                </div>
              </div>

              <div class="form-group row">
                <label class="col-sm-3 col-form-label hkf_text">প্রোফাইল ছবি</label>
                <div class="col-sm-3">
                  <input
                    type="file"
                    class="form-control-file"
                    id="exampleFormControlFile1"
                    @change="ProfileFileSelected"
                  />
                </div>
                <div class="col-md-4">
                  <td>
                    <img
                      v-if="clickOnChooseProfile"
                      :src="new_profile_photos"
                      alt=""
                      style="width: 50%; height: auto"
                    />
                    <img
                      v-else
                      :src="'/' + form.profile_photos"
                      style="width: 50%; height: auto"
                    />
                  </td>
                </div>
              </div>

              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text"></label>
                <div class="col-sm-8">
                  <button type="submit" class="btn btn-primary mb-2 register_client">
                    Update Client
                  </button>
                </div>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "edit_client",
  data() {
    return {
      errors: {},
      clickOnChooseTin: false,
      clickOnChooseNid: false,
      clickOnChoosePassport: false,
      clickOnChooseProfile: false,
      checkData: false,
      isBuilding: true,
      form: {
        name: "",
        father_name: "",
        mother_name: "",
        husban_wife_name: "",
        birth_date: "",
        religion: "",
        occupation: "",
        nationality: "",
        national_id_no: "",
        permanent_location: "",
        permanent_post_office: "",
        permanent_thana: "",
        permanent_district: "",
        temprorary_location: "",
        temprorary_post_office: "",
        temprorary_thana: "",
        temprorary_district: "",
        tin: "",
        phone: "",
        email: "",
        nid_img: "",
        passport_img: "",
        tin_img: "",
        profile_photos: "",
        clientUnderProject: "",
        new_nid_img: "",
        new_passport_img: "",
        new_tin_img: "",
        new_profile_photos: "",
        client_id: "",
        manager_username: "",
        guard: "",
        share: "",
      },
      isSubmitting: false,
      buildings: [],
      new_nid_img: "",
      new_passport_img: "",
      new_tin_img: "",
      new_profile_photos: "",
      projects: [],
    };
  },
  methods: {
    nidFileSelected(event) {
      this.clickOnChooseNid = true;

      let file = event.target.files[0];
      let reader = new FileReader();
      reader.onload = (event) => {
        this.form.new_nid_img = event.target.result;
        this.new_nid_img = this.form.new_nid_img;
      };
      reader.readAsDataURL(file);
    },
    passportFileSelected(event) {
      this.clickOnChoosePassport = true;
      let file = event.target.files[0];
      let reader = new FileReader();
      reader.onload = (event) => {
        this.form.new_passport_img = event.target.result;
        this.new_passport_img = this.form.new_passport_img;
      };
      reader.readAsDataURL(file);
    },
    tinFileSelected(event) {
      this.clickOnChooseTin = true;
      let file = event.target.files[0];
      let reader = new FileReader();
      reader.onload = (event) => {
        this.form.new_tin_img = event.target.result;
        this.new_tin_img = this.form.new_tin_img;
      };
      reader.readAsDataURL(file);
    },
    ProfileFileSelected(event) {
      this.clickOnChooseProfile = true;
      let file = event.target.files[0];
      let reader = new FileReader();
      reader.onload = (event) => {
        this.form.new_profile_photos = event.target.result;
        this.new_profile_photos = this.form.new_profile_photos;
      };
      reader.readAsDataURL(file);
    },
    addClient() {
      this.isSubmitting = true;

      let id = this.$route.params.id;
      const form1 = new FormData();
      form1.append("name", this.form.name);
      form1.append("father_name", this.form.father_name);
      form1.append("mother_name", this.form.mother_name);
      form1.append("husban_wife_name", this.form.husban_wife_name);
      form1.append("birth_date", this.form.birth_date);
      form1.append("religion", this.form.religion);
      form1.append("occupation", this.form.occupation);
      form1.append("nationality", this.form.nationality);
      form1.append("national_id_no", this.form.national_id_no);
      form1.append("permanent_location", this.form.permanent_location);
      form1.append("permanent_post_office", this.form.permanent_post_office);
      form1.append("permanent_thana", this.form.permanent_thana);
      form1.append("permanent_district", this.form.permanent_district);
      form1.append("temprorary_location", this.form.temprorary_location);
      form1.append("temprorary_post_office", this.form.temprorary_post_office);
      form1.append("temprorary_thana", this.form.temprorary_thana);
      form1.append("temprorary_district", this.form.temprorary_district);
      form1.append("tin", this.form.tin);
      form1.append("phone", this.form.phone);
      form1.append("email", this.form.email);
      form1.append("nid_img", this.form.nid_img);
      form1.append("new_nid_img", this.new_nid_img);
      form1.append("passport_img", this.form.passport_img);
      form1.append("new_passport_img", this.new_passport_img);
      form1.append("tin_img", this.form.tin_img);
      form1.append("new_tin_img", this.new_tin_img);
      form1.append("clientUnderProject", this.form.clientUnderProject);
      form1.append("client_id", this.form.client_id);
      form1.append("profile_photos", this.form.profile_photos);
      form1.append("new_profile_photos", this.new_profile_photos);
      form1.append("id", id);
      form1.append("selectedBuilding", this.form.selectedBuilding);
      form1.append("share", this.form.share);
      axios
        .post("/api/client/updateClient", form1, {
          headers: {
            "Content-Type": "mulitpart/form-data",
            Accept: "application/json",
          },
        })
        .then((res) => {
          console.log(res.data);
          this.$router.push({ name: "all_client" });
        })
        .catch((err) => {});
    },
  },
  computed: {
    checkOption() {
      if (this.form.clientUnderProject != "") {
        this.checkData = true;
        this.isBuilding = true;
        axios
          .get("/api/fetchBuildingInventory/" + this.form.clientUnderProject)
          .then((res) => {
            this.buildings = res.data;
          })
          .catch((err) => {
            console.log(err.response);
          });

        axios
          .get("/api/fetchProjectCode/" + this.form.clientUnderProject)
          .then((res) => {
            this.project_code = res.data.project_code;
          })
          .catch((err) => {
            console.log(err.response);
          });
      } else {
        this.checkData = false;
        this.isBuilding = false;
      }
    },
  },
  created() {
    if (!User.hasLoggedIn()) {
      this.$router.push({ name: "home" });
    } else {
      this.$router.push({ name: "edit_client" });
    }
    let id = this.$route.params.id;
    axios
      .get("/api/client/" + id)
      .then((res) => {
        this.form = res.data;
        axios
          .get("/api/fetchBuildingInventory/" + this.form.clientUnderProject)
          .then((res) => {
            this.buildings = res.data;
          })
          .catch((err) => {
            console.log(err.response);
          });
      })
      .catch((err) => {});

    //admin  & manager
    this.guard = User.getGuard();
    if (this.guard == "admin") {
      axios
        .get("/api/project")
        .then(({ data }) => {
          this.projects = data.map((item) => ({
            project_name: item.project_name,
            value: item.project_name,
            id: item.id,
          }));
        })
        .catch((err) => {
          this.errors = err.response.data;
        });
    } else if (this.guard == "manager") {
      this.manager_username = User.getUserName();
      axios
        .get("/api/getManagerProject/" + this.manager_username)
        .then((res) => {
          this.projects = res.data.map((item) => ({
            project_name: item.project,
            value: item.project,
            id: item.id,
          }));
        })
        .catch((err) => {});
    }
  },
};
</script>
<style>
input {
  border: 1px solid #adaadd !important;
}
.thikana {
  color: white !important;
  background: #5a629b;
  margin-left: 12%;
  margin-bottom: 2rem;
  text-align: center;
}
.register_client {
  margin-left: 70%;
}
</style>
