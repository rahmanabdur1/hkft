<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">Add Details</h2>
    <div class="input-group col-md-6 page_to_page">
      <router-link :to="{ name: 'all_purchase_land' }" class="btn btn-primary"
        >Land Details</router-link
      >
    </div>
    <div class="row">
      <div class="col-md-6 mx-auto">
        <form class="form" @submit.prevent="addLand()">
          <div class="form-group mx-sm-3 mb-2">
            <label for="projectName" class="hkf_text"
              >সিটি কর্পোরেশন/পৌর/ইউনিয়ন ভূমি অফিসের নাম</label
            >
            <input type="text" class="form-control" v-model="form.land_office" required />
          </div>
          <div class="form-group mx-sm-3 mb-2">
            <label for="location" class="hkf_text">মৌজার ও জে. এল. নং</label>
            <input type="text" class="form-control" v-model="form.moujar" required />
          </div>
          <div class="form-group mx-sm-3 mb-2">
            <label for="location" class="hkf_text">উপজেলা/থানা</label>
            <input type="text" class="form-control" v-model="form.thana" required />
          </div>
          <div class="form-group mx-sm-3 mb-2">
            <label for="location" class="hkf_text">জেলা</label>
            <input type="text" class="form-control" v-model="form.district" required />
          </div>
          <div class="form-group mx-sm-3 mb-2">
            <label for="location" class="hkf_text">মালিকের নাম</label>
            <input type="text" class="form-control" v-model="form.owner_name" required />
          </div>
          <div class="form-group mx-sm-3 mb-2">
            <label for="location" class="hkf_text">হোল্ডিং নাম্বার</label>
            <input
              type="text"
              class="form-control"
              v-model="form.holding_number"
              required
            />
          </div>
          <div class="form-group mx-sm-3 mb-2">
            <label for="location" class="hkf_text">জমির শ্রেণী</label>
            <input type="text" class="form-control" v-model="form.land_class" required />
          </div>
          <div class="form-group mx-sm-3 mb-2">
            <label for="location" class="hkf_text">খতিয়ান নং</label>
            <input type="text" class="form-control" v-model="form.ledger_no" required />
          </div>
          <div class="form-group mx-sm-3 mb-2">
            <label for="location" class="hkf_text">দাগ নং</label>
            <input type="text" class="form-control" v-model="form.dag_no" required />
          </div>
         <div class="form-group mx-sm-3 mb-2">
                  <label class="hkf_text">ফাইল</label>
                  <input
                    type="file"
                    class="form-control"
                    @change="selectedDocs"
                  />

                  <embed :src="Supporting_docs" type="application/pdf" />
                </div>
          <div style="width: 100%; text-align: right">
            <button type="submit" class="btn btn-primary mb-2">Save</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "add_purchase_land",

  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else if (User.getGuard() == "manager") {
        vm.$router.push({ name: "manager_dashboard" });
      } else {
        vm.$router.push({ name: "edit_purchase_land" });
      }
    });
  },
  data() {
    return {
      form: {
        land_office: "",
        moujar: "",
        thana: "",
        district: "",
        owner_name: "",
        holding_number: "",
        land_class: "",
        ledger_no: "",
        dag_no: "",
        id:"",
        Supporting_docs:"",
      },
    Supporting_docs: "",

    };
  },
  created() {
    axios.get("/api/purchase_land_details/" + this.$route.params.id).then((res) => {
      this.form = res.data;
      this.Supporting_docs = res.data.Supporting_docs;
    });
  },
  methods: {
      selectedDocs() {
      let file = event.target.files[0];
      let reader = new FileReader();
      reader.onload = (event) => {
        this.Supporting_docs = event.target.result;
        this.form.Supporting_docs = file;
      };

      reader.readAsDataURL(file);
    },
    addLand() {
        const formData = new FormData();
      formData.append("land_office", this.form.land_office);
      formData.append("moujar", this.form.moujar);
      formData.append("thana", this.form.thana);
      formData.append("district", this.form.district);
      formData.append("owner_name", this.form.owner_name);
      formData.append("holding_number", this.form.holding_number);
      formData.append("land_class", this.form.land_class);
      formData.append("ledger_no", this.form.ledger_no);
      formData.append("dag_no", this.form.dag_no);
      formData.append("Supporting_docs", this.form.Supporting_docs);
     formData.append("id", this.$route.params.id);

      axios
        .post("/api/purchase_land_details_update"  , formData, {
          headers: {
            "Content-Type": "multipart/form-data",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.$router.push({
            name: "view_purchase_land",
            params: { id: this.$route.params.id },
          });
        })
        .catch((error) => {
          this.errors = JSON.parse(error.response.data);
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
