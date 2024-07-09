<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">Add Member</h2>
    <div class="input-group col-md-6 page_to_page">
      <router-link :to="{ name: 'all_member' }" class="btn btn-primary"
        >All Member</router-link
      >
    </div>
    <div class="row">
      <div class="col-md-12 mx-auto">
        <form @submit.prevent="addMember()">
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label class="hkf_text">Project Name</label>
            <select class="form-control" v-model="form.project" required>
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
            <label for="projectName" class="hkf_text">Member Name</label>
            <input
              type="text"
              class="form-control"
              placeholder="Member Name"
              v-model="form.member_name"
              required
            />
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Phone</label>
            <input
              type="text"
              class="form-control"
              placeholder="Phone"
              v-model="form.phone_no"
              required
            />
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Share Number</label>
            <input
              type="number"
              class="form-control"
              placeholder="Share Number"
              v-model="form.share_number"
            />
          </div>
          <!-- -->
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Deposit Amount</label>
            <input
              type="text"
              class="form-control"
              placeholder="Deposit Amount"
              v-model="form.deposit_amount"
            />
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Paid Amount</label>
            <input
              type="text"
              class="form-control"
              placeholder="Paid Amount"
              v-model="form.paid_amount"
            />
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Due Amount</label>
            <input
              type="text"
              class="form-control"
              placeholder="Due Amount"
              v-model="form.due_amount"
            />
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Extra Amount</label>
            <input
              type="text"
              class="form-control"
              placeholder="Extra Amount"
              v-model="form.extra_amount"
            />
            <div class="col-md-12 text-right mt-2">
              <button type="submit" class="btn btn-primary mb-2">Save</button>
            </div>
          </div>

          <!-- -->
        </form>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "add_project",

  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else if (User.getGuard() == "manager") {
        vm.$router.push({ name: "manager_dashboard" });
      } else {
        vm.$router.push({ name: "add_member" });
      }
    });
  },
  data() {
    return {
      form: {
        project: "",
        member_name: "",
        phone_no: "",
        deposit_amount: "",
        paid_amount: "",
        extra_amount: "",
        due_amount: "",
        share_number: "",
      },
      projects:[],
    };
  },
  created(){
    axios.get('/api/project').then((res)=>{
        this.projects = res.data;

    }).catch((err)=>{
    })
  },
  methods: {
    addMember(){
        axios.post('/api/project_member',this.form).then((res)=>{
            this.$router.push({name:'all_member'});
        }).catch((err)=>{
        });
    }
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
