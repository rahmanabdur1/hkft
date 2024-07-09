<template>
  <div>

    <div class="input-group col-md-6 page_to_page">
      <router-link :to="{ name: 'all_member' }" class="btn btn-primary"
        >All Members</router-link
      >
    </div>
     <button
            type="button"
            class="btn action_print"
            style="margin-left: 85%"
            @click="printContent"
          >
            Print<i class="fa fa-print pl-2" aria-hidden="true"></i>
          </button>
    <div class="row">
      <div class="col-md-12 mx-auto" id='print-container'>
      <h2 class="text-center mb-4 hkf_title">Member : {{form.member_name}} </h2>
        <form>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="projectName" class="hkf_text">Project Name:</label>
            <label class="hkf_text">{{ form.project }}</label>
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label for="location" class="hkf_text">Member Name:</label>
            <label class="hkf_text">{{ form.member_name }}</label>
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2">
            <label class="hkf_text">Phone:</label>
            <label class="hkf_text">{{ form.phone_no }}</label>
          </div>
          <!-- -->
          <div class="form-group mx-sm-3 col-md-6 mb-2" v-if='form.share_number'>
            <label for="location" class="hkf_text">Share Number:</label>
            <label class="hkf_text">{{ form.share_number }}</label>
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2" v-if=' form.deposit_amount'>
            <label for="location" class="hkf_text">Deposit Amount:</label>
            <label class="hkf_text">{{ form.deposit_amount }} tk</label>
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2" v-if='form.paid_amount'>
            <label for="location" class="hkf_text">Paid Amount:</label>
            <label class="hkf_text">{{ form.paid_amount }} tk</label>
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2" v-if='form.due_amount'>
            <label for="location" class="hkf_text">Due Amount:</label>
            <label class="hkf_text">{{ form.due_amount }} tk</label>
          </div>
          <div class="form-group mx-sm-3 col-md-6 mb-2" v-if='form.extra_amount'>
            <label for="location" class="hkf_text">Extra Amount:</label>
            <label class="hkf_text">{{ form.extra_amount }} tk</label>
          </div>

          <!-- -->
        </form>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "view_member",
  data() {
    return {
      form: {
        project: "",
        member_name: "",
        phone_no: "",
        share_number: "",
        deposit_amount: "",
        paid_amount: "",
        due_amount: "",
        extra_amount: "",
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
      .get("/api/project_member/" + id)
      .then(({ data }) => {
        this.form = data;
      })
      .catch((err) => {
        console.log(err.response);
      });
  },
  methods: {printContent() {
      const printContents = document.getElementById("print-container").innerHTML;
      const originalContents = document.body.innerHTML;
      const popupWin = window.open("width=800,height=800");
      popupWin.document.open();
      popupWin.document.write(`
        <html>
          <head>
            <style>
              /* Your styles go here */
              *{
                padding:0.25rem;
              }

            </style>
          </head>
          <body onload="window.print();window.close();">${printContents}</body>
        </html>
      `);
      popupWin.document.close();
      this.$router.push({
        name: "view_member",
        params: { id: this.$route.params.id },
      });
    },},
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else if (User.getGuard() == "manager") {
        vm.$router.push({ name: "manager_dashboard" });
      } else {
        vm.$router.push({ name: "view_member" });
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
