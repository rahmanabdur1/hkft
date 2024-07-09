<template>
  <div class="row">
    <div class="col-md-12 mx-auto">
      <h2 class="text-center mb-4 hkf_title">Add Client</h2>
      <button
        type="button"
        class="action btn text-right"
        style="width: 80px; margin-left: 80%; margin-top: 1rem; margin-bottom: 1rem"
        @click="translate"
      >
        Translate
      </button>
      <div class="row">
        <div class="col-md-10 mx-auto">
          <form @submit.prevent="addClient()">
            <div class="form-group row">
              <label class="col-sm-2 col-form-label hkf_text" style="font-size: 1.2em"
                >Select Project</label
              >
              <div class="col-sm-8">
                <select
                  class="form-control status"
                  v-model="form.clientUnderProject"
                  @change="checkOption"
                >
                  <option
                    v-for="(project, index) in projects"
                    :value="project.value"
                    :key="index"
                  >
                    {{ project.project_name }}
                  </option>
                </select>
                <small class="text text-danger" v-if="errors.clientUnderProject">{{
                  errors.clientUnderProject[0]
                }}</small>
              </div>
            </div>
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
              <label class="col-sm-2 col-form-label hkf_text" style="font-size: 1.2em"
                >Select Client Status</label
              >
              <div class="col-sm-8">
                <select
                  class="form-control status"
                  v-model="client.statuses"
                  @change="checkClient"
                >
                  <option
                    v-for="(client, index) in clientStatus"
                    :key="index"
                    :value="client.status"
                  >
                    {{ client.status }}
                  </option>
                </select>
              </div>
            </div>
            <div class="form-group row" v-if="client_profile">
              <label class="col-sm-2 col-form-label hkf_text" style="font-size: 1.2em"
                >Client:</label
              >
              <input
                type="text"
                class="form-control status col-sm-8"
                placeholder="Client (Search By Name, ID, Phone)"
                v-model="client_search"
                @keyup="listDisplay"
              />
              <ul class="ulShow col-sm-12 text-center" :class="{ listStyle: list_style }">
                <li
                  class="listShow"
                  :class="{ listStyle: list_style }"
                  v-for="(item, index) in filterSearch"
                  :key="index"
                  :value="item.name"
                  @click="assignToSearch(item)"
                >
                  {{ item.name }}
                </li>
              </ul>
            </div>
            <div v-show="client_status && bangla">
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">নাম</label>
                <div class="col-sm-8">
                  <input type="text" class="form-control" v-model="form.name" />
                  <small class="text text-danger" v-if="errors.name">{{
                    errors.name[0]
                  }}</small>
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">পিতার নাম</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control status"
                    v-model="form.father_name"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">মাতার নাম</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control status"
                    v-model="form.mother_name"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">স্বামি/স্ত্রীর নাম</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control status"
                    v-model="form.husban_wife_name"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">জন্ম তারিখ</label>
                <div class="col-sm-8">
                  <input
                    type="date"
                    class="form-control status"
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
                    class="form-control status"
                    v-model="form.religion"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">পেশা</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control status"
                    v-model="form.occupation"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">জাতীয়তা</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control status"
                    v-model="form.nationality"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">জাতীয় আইডি নং</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control status"
                    v-model="form.national_id_no"
                  />
                  <small class="text text-danger" v-if="errors.national_id_no">{{
                    errors.national_id_no[0]
                  }}</small>
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
                    class="form-control status"
                    v-model="form.permanent_location"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">ডাকঘর</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control status"
                    v-model="form.permanent_post_office"
                  />
                </div>
              </div>

              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">থানা/উপজেলা</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control status"
                    v-model="form.permanent_thana"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">জেলা</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control status"
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
                    class="form-control status"
                    v-model="form.temprorary_location"
                  />
                  <small class="text text-danger" v-if="errors.temprorary_location">{{
                    errors.temprorary_location[0]
                  }}</small>
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">ডাকঘর</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control status"
                    v-model="form.temprorary_post_office"
                  />
                </div>
              </div>

              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">থানা/উপজেলা</label>
                <div class="col-sm-6">
                  <input
                    type="text"
                    class="form-control status"
                    v-model="form.temprorary_thana"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">জেলা</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control status"
                    v-model="form.temprorary_district"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">টি. আই. এন</label>
                <div class="col-sm-8">
                  <input type="text" class="form-control status" v-model="form.tin" />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">মোবাইল নাম্বার</label>
                <div class="col-sm-8">
                  <input type="text" class="form-control status" v-model="form.phone" />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">ইমেল আইডি</label>
                <div class="col-sm-8">
                  <input type="email" class="form-control status" v-model="form.email" />
                  <small class="text text-danger" v-if="errors.email">{{
                    errors.email[0]
                  }}</small>
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">শেয়ার</label>
                <div class="col-sm-8">
                  <input type="text" class="form-control status" v-model="form.share" />
                  <small class="text text-danger" v-if="errors.share">{{
                    errors.share[0]
                  }}</small>
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
                    @change="nidFileSelected"
                  />
                  <small class="text text-danger" v-if="errors.nid_img">{{
                    errors.nid_img[0]
                  }}</small>
                </div>
                <div class="col-md-4">
                  <td>
                    <img :src="form.nid_img" alt="" style="width: 50%; height: auto" />
                  </td>
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-3 col-form-label hkf_text">পাসপোর্টের ফটোকপি</label>
                <div class="col-sm-3">
                  <input
                    type="file"
                    class="form-control-file"
                    @change="passportFileSelected"
                  />
                </div>
                <div class="col-md-4">
                  <td>
                    <img
                      :src="form.passport_img"
                      alt=""
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
                    @change="tinFileSelected"
                  />
                </div>
                <div class="col-md-4">
                  <td>
                    <img :src="form.tin_img" alt="" style="width: 50%; height: auto" />
                  </td>
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-3 col-form-label hkf_text">প্রোফাইল ছবি</label>
                <div class="col-sm-3">
                  <input
                    type="file"
                    class="form-control-file"
                    @change="profileFileSelected"
                  />
                </div>

                <div class="col-md-4">
                  <td>
                    <img
                      :src="form.profile_photos"
                      alt=""
                      style="width: 50%; height: auto"
                    />
                  </td>
                </div>
              </div>
            </div>
            <div v-show="client_status && english">
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">Name</label>
                <div class="col-sm-8">
                  <input type="text" class="form-control status" v-model="form.name" />
                  <small class="text text-danger" v-if="errors.name">{{
                    errors.name[0]
                  }}</small>
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">Father's Name</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control status"
                    v-model="form.father_name"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">Mother's Name</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control status"
                    v-model="form.mother_name"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">Husband/Wife Name</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control status"
                    v-model="form.husban_wife_name"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">Birth Date</label>
                <div class="col-sm-8">
                  <input
                    type="date"
                    class="form-control status"
                    v-model="form.birth_date"
                  />
                  <small class="text text-danger" v-if="errors.birth_date">{{
                    errors.birth_date[0]
                  }}</small>
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">Religion</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control status"
                    v-model="form.religion"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">Occupation</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control status"
                    v-model="form.occupation"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">Nationality</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control status"
                    v-model="form.nationality"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">National ID No</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control status"
                    v-model="form.national_id_no"
                  />
                  <small class="text text-danger" v-if="errors.national_id_no">{{
                    errors.national_id_no[0]
                  }}</small>
                </div>
              </div>

              <div class="row">
                <label class="col-sm-8 col-form-label thikana" style="color: black"
                  >Permanent Address</label
                >
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">Village/Road</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control status"
                    v-model="form.permanent_location"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">Post Office</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control status"
                    v-model="form.permanent_post_office"
                  />
                </div>
              </div>

              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text"
                  >Police Station/Upazila</label
                >
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control status"
                    v-model="form.permanent_thana"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">District</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control status"
                    v-model="form.permanent_district"
                  />
                </div>
              </div>

              <div class="row">
                <label class="col-sm-8 col-form-label thikana" style="color: black"
                  >Present Address</label
                >
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">Village/Road</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control status"
                    v-model="form.temprorary_location"
                  />
                  <small class="text text-danger" v-if="errors.temprorary_location">{{
                    errors.temprorary_location[0]
                  }}</small>
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">Post Office</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control status"
                    v-model="form.temprorary_post_office"
                  />
                </div>
              </div>

              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text"
                  >Police Station/Upazila</label
                >
                <div class="col-sm-6">
                  <input
                    type="text"
                    class="form-control status"
                    v-model="form.temprorary_thana"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">District</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    class="form-control status"
                    v-model="form.temprorary_district"
                  />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">T. I. N.</label>
                <div class="col-sm-8">
                  <input type="text" class="form-control status" v-model="form.tin" />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">Mobile Number</label>
                <div class="col-sm-8">
                  <input type="text" class="form-control status" v-model="form.phone" />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">Email</label>
                <div class="col-sm-8">
                  <input type="email" class="form-control status" v-model="form.email" />
                  <small class="text text-danger" v-if="errors.email">{{
                    errors.email[0]
                  }}</small>
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-2 col-form-label hkf_text">Share</label>
                <div class="col-sm-8">
                  <input type="text" class="form-control status" v-model="form.share" />
                  <small class="text text-danger" v-if="errors.share">{{
                    errors.share[0]
                  }}</small>
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-3 col-form-label hkf_text"> NID Photocopy</label>
                <div class="col-sm-3">
                  <input
                    type="file"
                    class="form-control-file"
                    @change="nidFileSelected"
                  />
                  <small class="text text-danger" v-if="errors.nid_img">{{
                    errors.nid_img[0]
                  }}</small>
                </div>
                <div class="col-md-4">
                  <td>
                    <img :src="form.nid_img" alt="" style="width: 50%; height: auto" />
                  </td>
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-3 col-form-label hkf_text">Passport Photocopy</label>
                <div class="col-sm-3">
                  <input
                    type="file"
                    class="form-control-file"
                    @change="passportFileSelected"
                  />
                </div>
                <div class="col-md-4">
                  <td>
                    <img
                      :src="form.passport_img"
                      alt=""
                      style="width: 50%; height: auto"
                    />
                  </td>
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-3 col-form-label hkf_text">T. I. N. Photocopy</label>
                <div class="col-sm-3">
                  <input
                    type="file"
                    class="form-control-file"
                    @change="tinFileSelected"
                  />
                </div>

                <div class="col-md-4">
                  <td>
                    <img :src="form.tin_img" alt="" style="width: 50%; height: auto" />
                  </td>
                </div>
              </div>
              <div class="form-group row">
                <label class="col-sm-3 col-form-label hkf_text">Profile Photo</label>
                <div class="col-sm-3">
                  <input
                    type="file"
                    class="form-control-file"
                    @change="profileFileSelected"
                  />
                </div>

                <div class="col-md-4">
                  <td>
                    <img
                      :src="form.profile_photos"
                      alt=""
                      style="width: 50%; height: auto"
                    />
                  </td>
                </div>
              </div>
            </div>
            <div class="form-group row">
              <label class="col-sm-2 col-form-label hkf_text"></label>
              <div class="col-sm-8">
                <button type="submit" class="btn btn-primary mb-2 register_client">
                  Register Client
                </button>
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
  name: "add_client",
  data() {
    return {
      errors: {},
      client: {
        statuses: "",
        name: "",
      },
      client_search: "",
      buildings: "",
      bangla: true,
      english: false,
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
        clientUnderProject: "",
        client_id: "",
        profile_photos: "",
        selectedBuilding: "",
        share: "",
      },
      clientStatus: [{ status: "Exist" }, { status: "New" }],
      newform: {
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
        clientUnderProject: "",
        profile_photos: "",
        client_id: "",
        share: "",
      },
      list_style: true,
      selectedProject: "",
      isBuilding: false,
      guard: "",
      checkData: false,
      projects: [],
      client_status: false,
      clients: [],
      client_profile: false,
      exist_button: false,
      existing: false,
      newentry: false,
      client_id: "",
      manager_username: "",
      project_code: "",
      temp_id: "",
      isSubmitting: false,
    };
  },
  methods: {
    translate() {
      if (this.bangla == true) {
        this.bangla = false;
        this.english = true;
      } else if (this.english == true) {
        this.english = false;
        this.bangla = true;
      }
    },
    nidFileSelected(event) {
      let file = event.target.files[0];
      let reader = new FileReader();
      reader.onload = (event) => {
        this.form.nid_img = event.target.result;
      };
      reader.readAsDataURL(file);
    },
    passportFileSelected(event) {
      let file = event.target.files[0];
      let reader = new FileReader();
      reader.onload = (event) => {
        this.form.passport_img = event.target.result;
      };
      reader.readAsDataURL(file);
    },
    tinFileSelected(event) {
      let file = event.target.files[0];
      let reader = new FileReader();
      reader.onload = (event) => {
        this.form.tin_img = event.target.result;
      };
      reader.readAsDataURL(file);
    },
    profileFileSelected() {
      let file = event.target.files[0];
      let reader = new FileReader();
      reader.onload = (event) => {
        this.form.profile_photos = event.target.result;
      };
      reader.readAsDataURL(file);
    },
    listDisplay() {
      this.list_style = false;
    },
    addClient() {
      if (this.isSubmitting) {
        return;
      }
      this.isSubmitting = true;

      if (this.newentry) {
        axios
          .get("/api/idMaker/" + this.form.selectedBuilding)
          .then((res) => {
            this.temp_id = this.form.selectedBuilding + "-" + res.data;
            this.form.client_id = this.temp_id;
            console.log(this.form.client_id);
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
            form1.append("passport_img", this.form.passport_img);
            form1.append("tin_img", this.form.tin_img);
            form1.append("clientUnderProject", this.form.clientUnderProject);
            form1.append("client_id", this.form.client_id);
            form1.append("profile_photos", this.form.profile_photos);
            form1.append("selectedBuilding", this.form.selectedBuilding);
            form1.append("share", this.form.share);

            axios
              .post("/api/client", form1, {
                headers: {
                  "Content-Type": "multipart/form-data",
                  Accept: "application/json",
                },
              })
              .then((res) => {
                console.log(res.data);
                this.$router.push({ name: "all_client" });
              })
              .catch((err) => {
                this.errors = JSON.parse(err.response.data);
                console.log(err.response);
              });
          })
          .catch((err) => {
            console.log(err.response);
          });
      } else if (this.existing) {
        let id = this.client_id;

        let newProject = this.form.clientUnderProject;
        let newBuilding = this.form.selectedBuilding;
        axios
          .get("/api/client/" + id)
          .then((res) => {
            this.form = res.data;

            if (this.form) {
              axios
                .get("/api/idMaker/" + newBuilding)
                .then((res) => {
                  this.form.client_id = newBuilding + "-" + res.data;
                  const form2 = new FormData();
                  form2.append("name", this.form.name);
                  form2.append("father_name", this.form.father_name);
                  form2.append("mother_name", this.form.mother_name);
                  form2.append("husban_wife_name", this.form.husban_wife_name);
                  form2.append("birth_date", this.form.birth_date);
                  form2.append("religion", this.form.religion);
                  form2.append("occupation", this.form.occupation);
                  form2.append("nationality", this.form.nationality);
                  form2.append("national_id_no", this.form.national_id_no);
                  form2.append("permanent_location", this.form.permanent_location);
                  form2.append("permanent_post_office", this.form.permanent_post_office);
                  form2.append("permanent_thana", this.form.permanent_thana);
                  form2.append("permanent_district", this.form.permanent_district);
                  form2.append("temprorary_location", this.form.temprorary_location);
                  form2.append(
                    "temprorary_post_office",
                    this.form.temprorary_post_office
                  );
                  form2.append("temprorary_thana", this.form.temprorary_thana);
                  form2.append("temprorary_district", this.form.temprorary_district);
                  form2.append("tin", this.form.tin);
                  form2.append("phone", this.form.phone);
                  form2.append("email", this.form.email);
                  form2.append("nid_img", this.form.nid_img);
                  form2.append("passport_img", this.form.passport_img);
                  form2.append("tin_img", this.form.tin_img);
                  form2.append("clientUnderProject", newProject);
                  form2.append("client_id", this.form.client_id);
                  form2.append("profile_photos", this.form.profile_photos);
                  form2.append("selectedBuilding", newBuilding);
                  form2.append("share", this.form.share);
                  axios
                    .post("/api/client/existing_entry", form2, {
                      headers: {
                        "Content-Type": "multipart/form-data",
                        Accept: "application/json",
                      },
                    })
                    .then((res) => {
                      console.log(res.data);
                      this.$router.push({ name: "all_client" });
                    })
                    .catch((err) => console.log(err.response));
                })
                .catch((err) => {
                  console.log(err.response);
                });
            }
          })
          .catch((err) => {
            console.log(err.response);
          });
      }
    },
    assignToSearch(item) {
      this.list_style = true;
      this.client_search = item.name;
      this.client_id = item.id;
    },
  },
  computed: {
    filterSearch() {
      return this.clients.filter((client) => {
        const search_Term = this.client_search.toLowerCase();
        const typeName = client.name.toLowerCase();
        const phone = client.phone.toLowerCase();
        const client_id = client.client_id.toLowerCase();
        if (phone) {
          return (
            typeName.includes(search_Term) ||
            phone.includes(search_Term) ||
            client_id.includes(search_Term)
          );
        } else if (!phone) {
          return typeName.includes(search_Term) || client_id.includes(search_Term);
        }
      });
    },
    checkClient() {
      if (this.client.statuses == "Exist") {
        this.client_status = false;
        this.existing = true;
        this.newentry = false;
        this.client_profile = true;
      } else {
        this.client_status = true;
        this.client_profile = false;
        this.existing = false;
        this.newentry = true;
      }
    },
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

    chooseClient() {
      this.clients.forEach((item) => {
        if (item.name == this.client.name) {
          this.client_id = item.id;
        }
      });
    },
  },
  created() {
    if (!User.hasLoggedIn()) {
      this.$router.push({ name: "home" });
    } else {
      this.$router.push({ name: "add_client" });
    }

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

    axios
      .get("/api/client")
      .then((res) => {
        this.clients = res.data;
      })
      .catch((err) => {});
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
