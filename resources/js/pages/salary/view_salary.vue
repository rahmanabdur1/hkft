<template>
  <div class="row">
    <div class="col-md-12 mx-auto">
      <div class="row">
        <div class="col-md-10 mx-auto">
          <button
            type="button"
            class="btn action_print"
            style="margin-left: 85%"
            @click="printContent"
          >
            Print<i class="fa fa-print pl-2" aria-hidden="true"></i>
          </button>

          <form>
            <div id="print-container">
            <div style="display: flex">
          <div class="sidebar-brand-icon" style="text-align: left; width: 20%">
            <img
              class="logo"
              :src="'../img/'+avatar"
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
              <h2
                class="hkf_title_print_only"
                style="padding: 0.5rem; color: black; text-align: center"
              >
                Salary Details
              </h2>

              <div class="row rowPhotoDiv">
                <div class="col-md-12 colPhotoDiv">
                 <div class="form-group row">
                    <label class="col-sm-10 col-form-label hkf_text_print"
                      ><td
                        class="td_label_info"
                        style="font-size: 1.2em; font-weight: bold"
                      >
                        Employee ID:
                      </td>
                      <td class="td_label_data">
                        {{ form.employee_id }}
                      </td></label
                    >
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-10 col-form-label hkf_text_print"
                      ><td
                        class="td_label_info"
                        style="font-size: 1.2em; font-weight: bold"
                      >
                        Date:
                      </td>
                      <td class="td_label_data">{{ form.basic_date }}</td>
                    </label>
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-10 col-form-label hkf_text_print"
                      ><td
                        class="td_label_info"
                        style="font-size: 1.2em; font-weight: bold"
                      >
                        Employee Name:
                      </td>
                      <td class="td_label_data">
                        {{ form.employee_name }}
                      </td></label
                    >
                  </div>
                   <div class="form-group row">
                    <label class="col-sm-10 col-form-label hkf_text_print"
                      ><td
                        class="td_label_info"
                        style="font-size: 1.2em; font-weight: bold"
                      >
                         Project:
                      </td>
                      <td class="td_label_data">
                        {{ form.selectedProject }}
                      </td></label
                    >
                  </div>
                   <div class="form-group row">
                    <label class="col-sm-10 col-form-label hkf_text_print"
                      ><td
                        class="td_label_info"
                        style="font-size: 1.2em; font-weight: bold"
                      >
                        Building:
                      </td>
                      <td class="td_label_data">
                        {{ form.selectedBuilding }}
                      </td></label
                    >
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-10 col-form-label hkf_text_print"
                      ><td
                        class="td_label_info"
                        style="font-size: 1.2em; font-weight: bold"
                      >
                        Payment:
                      </td>
                      <td class="td_label_data">{{ form.selectedPaymentType }}</td></label
                    >
                  </div>
                  <div class="form-group row" v-if='form.cash_bank_account'>
                    <label class="col-sm-10 col-form-label hkf_text_print"
                      ><td
                        class="td_label_info"
                        style="font-size: 1.2em; font-weight: bold"
                      >
                        Account No:
                      </td>
                      <td class="td_label_data">{{ form.cash_bank_account }}</td></label
                    >
                  </div>
                   <div class="form-group row" v-if='form.bank_name'>
                    <label class="col-sm-10 col-form-label hkf_text_print"
                      ><td
                        class="td_label_info"
                        style="font-size: 1.2em; font-weight: bold"
                      >
                        Bank Name:
                      </td>
                      <td class="td_label_data">{{ form.bank_name }}</td></label
                    >
                  </div>
                   <div class="form-group row" v-if='form.bank_branch'>
                    <label class="col-sm-10 col-form-label hkf_text_print"
                      ><td
                        class="td_label_info"
                        style="font-size: 1.2em; font-weight: bold"
                      >
                        Bank Name:
                      </td>
                      <td class="td_label_data">{{ form.bank_branch }}</td></label
                    >
                  </div>
                   <div class="form-group row" v-if='form.bank_cheque_date'>
                    <label class="col-sm-10 col-form-label hkf_text_print"
                      ><td
                        class="td_label_info"
                        style="font-size: 1.2em; font-weight: bold"
                      >
                        Bank Name:
                      </td>
                      <td class="td_label_data">{{ form.bank_cheque_date }}</td></label
                    >
                  </div>
                   <div class="form-group row" v-if='form.bank_cheque_no'>
                    <label class="col-sm-10 col-form-label hkf_text_print"
                      ><td
                        class="td_label_info"
                        style="font-size: 1.2em; font-weight: bold"
                      >
                        Bank Name:
                      </td>
                      <td class="td_label_data">{{ form.bank_cheque_no }}</td></label
                    >
                  </div>
                       <div class="form-group row">
                    <label class="col-sm-10 col-form-label hkf_text_print"
                      ><td
                        class="td_label_info"
                        style="font-size: 1.2em; font-weight: bold"
                      >
                        Paid Month-Year :
                      </td>
                      <td class="td_label_data">{{ form.paid_month }}-{{form.paid_year}}</td></label
                    >
                  </div>
                 <div class="form-group row" >
                    <label class="col-sm-10 col-form-label hkf_text_print"
                      ><td
                        class="td_label_info"
                        style="font-size: 1.2em; font-weight: bold"
                      >
                        Basic Salary:
                      </td>
                      <td class="td_label_data">{{ form.basic_salary }}tk</td></label
                    >
                  </div>
                  <div class="form-group row" v-if='form.commission'>
                    <label class="col-sm-10 col-form-label hkf_text_print"
                      ><td
                        class="td_label_info"
                        style="font-size: 1.2em; font-weight: bold"
                      >
                       Commission:
                      </td>
                      <td class="td_label_data">{{ form.commission }}tk</td></label
                    >
                  </div>



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
  name: "view_client",

  data() {
    return {
        avatar:'logo.png',
      form: {
       basic_date: "",
        selectedPaymentType: "",
        cash_bank_account: "",
        selectedProject: "",
        employee_name: "",
        employee_address: "",
        employee_phone: "",
        employee_designation: "",
        bank_cheque_no: "",
        bank_cheque_date: "",
        bank_name: "",
        bank_branch: "",
        basic_salary: "",
        commission: "",
        employee_id: "",
        paid_month: "",
        paid_year: "",
      },
      salary_history: [],
      project_location: "",
      projects_temp: [],
      Id: "",
      hideLink:false,
    };
  },
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else {
        vm.$router.push({ name: "view_salary" });
      }
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
              .rowPhotoDiv {
                width: 100%;
                display:flex;
              }
              .colPhotoDiv {
                width: 50%;
              }
              .passport_img {
                margin-left:25%;
                width: 120px;
                height: 160px;
                margin-top:-15%;
              }
              .thikana_print{
                border-bottom:1px solid black;
                font-size:1.1em;
              }
             td{
              margin:0.5em;
             }
             .td_label_print {
                padding-right: 0.25rem;;
                width:100%;
              }
              .td_label_data {
                 margin-right: 0.5rem;
                }
                label{
                  padding:.5rem;
                }
                .print_table {

                   width:650px;
                }
                .print_table td {
                  padding: 0.5rem 0rem 0.5rem 1rem;
}
               .hkf_title_print_only{
                 margin-top:-1%;
                  color: black ;
                  text-align: center;
                }
            </style>
          </head>
          <body onload="window.print();window.close();">${printContents}</body>
        </html>
      `);
      popupWin.document.close();
      this.$router.push({ name: "view_salary", params: { id: this.$route.params.id } });
    },
  },
  created() {
    let id = this.$route.params.id;
    this.Id = id;




    axios
      .get("/api/project")
      .then((res) => {
        this.projects_temp = res.data;
        this.projects_temp.forEach((item) => {
          if (item.project_name == this.form.clientUnderProject) {
            this.project_location = item.project_address;
          }
        });
      })
      .catch((err) => {
        console.log(err);
      });
       axios.get('/api/salary/'+this.$route.params.id).then((res)=>{
        this.form = res.data;
      }).catch((err)=>{
        console.log(err.response);
      });
  },
};
</script>
<style>
.thikana_print {
  color: black !important;
  background: white;
  margin-left: 20%;
  margin-bottom: 2rem;
  text-align: center;
  padding: 0.5rem;
}
.action_print {
  color: white;
  background: #5d57c3;
  padding: 5px;
  width: 90px;
}
.td_label_print {
  padding-right: 1em;
  width: 100%;
}
.td_label_data {
  color: black !important;
  margin-right: 0.5rem;
}
.passport_img {
  width: 150px;
  height: 150px;
}
.print-container {
  margin-top: 1rem;
}
.print_table {
  min-width: 400px;
  width: 590px;
}
.print_table td {
  padding: 0.5rem 0rem 0.5rem 1rem;
}
.hkf_text_print {
  color: black;
}
.td_label_info {
  padding-right: 0.5rem;
}
@media print {
  .rowPhotoDiv {
    width: 100%;
  }
  .colPhotoDiv {
    width: 50%;
  }
  .passport_img {
    width: 120px;
    height: 90px;
  }
  .hkf_title_print_only {
    padding: 0.5rem;
    color: black;
    text-align: center;
  }
}
</style>
