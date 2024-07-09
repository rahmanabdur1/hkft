<template>
  <div>
    <div class="input-group col-md-6 page_to_page"></div>
    <button
      type="button"
      class="btn action_print mb-5"
      style="margin-left: 85%"
      @click="printContent"
    >
      Print<i class="fa fa-print pl-2" aria-hidden="true"></i>
    </button>
    <div class="row">
      <div class="col-md-12 mx-auto" id="print-container">
        <div style="display: flex">
          <div class="sidebar-brand-icon" style="text-align: left; width: 20%">
            <img
              class="logo"
              :src="'../img/' + avatar"
              style="width: 165%; height: 77%"
              alt=""
            />
          </div>
          <div style="padding: 5%; width: 80%">
            <h3 style="text-align: center">HKF Real Estate LTD</h3>
            <h4 style="text-align: center">
              117/2/8 1st Floor Sopnodanga Residential Area<br />
              Phone: 01400407270 <br />
              Email:contact@hkf-re.com <br />
              Website: www.hkf-re.com
            </h4>
          </div>
        </div>
        <h1
          class="text-center hkf_texts mb-4"
          style="text-align: center; font-weight: 500"
        >
          Project: {{ this.$route.params.id }}
        </h1>
        <h2 class="hkf_title text-center mb-4" style="text-align: center">
          সদস্যদের তালিকা
        </h2>
        <table
          class="table"
          cellspacing="0"
          style="border: 1px solid black; border-collapse: collapse; text-align: center"
        >
          <thead style="border: 1px solid black; border-collapse: collapse">
            <tr>
              <th style="border: 1px solid black; border-collapse: collapse">ক্রঃ নংঃ</th>
              <th style="border: 1px solid black; border-collapse: collapse">
                নামের তালিকা
              </th>
              <th style="border: 1px solid black; border-collapse: collapse">
                মোবাইল নাম্বার
              </th>
              <th style="border: 1px solid black; border-collapse: collapse">
                শেয়ার সংখ্যা
              </th>
              <th style="border: 1px solid black; border-collapse: collapse">
                মোট ধার্যকৃত টাকা
              </th>
              <th style="border: 1px solid black; border-collapse: collapse">
                আদায়কৃত টাকা
              </th>
              <th style="border: 1px solid black; border-collapse: collapse">
                বকেয়া কৃত টাকা
              </th>
              <th style="border: 1px solid black; border-collapse: collapse">
                অতিরিক্ত টাকা
              </th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(project, index) in members" :key='index' >
              <td style="border: 1px solid black; border-collapse: collapse">
                {{ index + 1 }}
              </td>
              <td style="border: 1px solid black; border-collapse: collapse">
                {{ project.client_name }}
              </td>
              <td style="border: 1px solid black; border-collapse: collapse">
                {{ project.phone }}
              </td>
              <td style="border: 1px solid black; border-collapse: collapse">
                {{ project.share }}
              </td>
              <td style="border: 1px solid black; border-collapse: collapse">
                {{ project.total_amount }} tk
              </td>
              <td style="border: 1px solid black; border-collapse: collapse">
                {{ project.total_paid }} tk
              </td>
              <td style="border: 1px solid black; border-collapse: collapse">
                {{ project.total_due }} tk
              </td>
              <td style="border: 1px solid black; border-collapse: collapse">
                {{ project.advance }} tk
              </td>
            </tr>
            <tr>
              <td style="border: 1px solid black; border-collapse: collapse">মোট</td>
              <td style="border: 1px solid black; border-collapse: collapse">
                {{ clientName }}
              </td>
              <td style="border: 1px solid black; border-collapse: collapse">
                {{ phone }}
              </td>
              <td style="border: 1px solid black; border-collapse: collapse">
                {{ share }}
              </td>
              <td style="border: 1px solid black; border-collapse: collapse">
                {{ totalAmount }} tk
              </td>
              <td style="border: 1px solid black; border-collapse: collapse">
                {{ paidAmount }} tk
              </td>
              <td style="border: 1px solid black; border-collapse: collapse">
                {{ dueAmount }} tk
              </td>
              <td style="border: 1px solid black; border-collapse: collapse">
                {{ extraAmount }} tk
              </td>
            </tr>

            <!-- add more rows as needed -->
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "view_member",
  data() {
    return {
      //   form: {
      //     project: "",
      //     member_name: "",
      //     phone_no: "",
      //     share_number: "",
      //     deposit_amount: "",
      //     paid_amount: "",
      //     due_amount: "",
      //     extra_amount: "",
      //   },
      avatar: "logo.png",

      form: {
        client_name: "",
        phone: "",
        share: "",
        total_amount: "",
        total_paid: "",
        total_due: "",
      },

      members: [],
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
      project: "",
      clients: [],
      clientsArray: "",
      clientName: "",
      index: "",
      phone: "",
      share: "",
      arrayProxy: "",
      totalAmount: 0,
      paidAmount: 0,
      dueAmount: 0,
      extraAmount: 0,
    };
  },
  created() {
    axios.get("/api/fetch_client_by_project/" + this.$route.params.id).then((res) => {
      this.members = res.data;
       this.filterMembers = Object.values(
          this.members.reduce((uniqueClients, data) => {
            console.log(uniqueClients);
            console.log(data);
            const { client_id } = data;
            uniqueClients[client_id] = data;
            return uniqueClients;
          }, {})
        );
      this.filterMembers.forEach((item) => {
        this.totalAmount += parseInt(item.total_amount);
        this.paidAmount += parseInt(item.total_paid);
        this.dueAmount += parseInt(item.total_due);
        this.extraAmount += parseInt(item.advance);
      });
    });
  },
  methods: {
    printContent() {
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
        name: "project_base_member",
        params: { id: this.$route.params.id },
      });
    },
  },
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else {
        vm.$router.push({ name: "project_base_member" });
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
