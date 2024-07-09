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
              <div style="display: flex; border-bottom: 1px solid black" class="mb-3">
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
                Employee Details
              </h2>

              <div class="row rowPhotoDiv">
                <div class="col-md-12 colPhotoDiv">
                  <div class="form-group row">
                    <label class="col-sm-10 col-form-label hkf_text_print"
                      ><td
                        class="td_label_info"
                        style="font-size: 1.2em; font-weight: bold"
                      >
                        Employee Name:
                      </td>
                      <td class="td_label_data">{{ form.employee_name }}</td>
                    </label>
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-10 col-form-label hkf_text_print"
                      ><td
                        class="td_label_info"
                        style="font-size: 1.2em; font-weight: bold"
                      >
                        Employee Designation:
                      </td>
                      <td class="td_label_data">
                        {{ form.employee_designation }}
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
                      <td class="td_label_data">{{ form.selectedProject }}</td></label
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
                      <td class="td_label_data">{{ form.building_name }}</td></label
                    >
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-10 col-form-label hkf_text_print"
                      ><td
                        class="td_label_info"
                        style="font-size: 1.2em; font-weight: bold"
                      >
                        Employee Address:
                      </td>
                      <td class="td_label_data">{{ form.employee_address }}</td></label
                    >
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-10 col-form-label hkf_text_print"
                      ><td
                        class="td_label_info"
                        style="font-size: 1.2em; font-weight: bold"
                      >
                        Employee Phone:
                      </td>
                      <td class="td_label_data">{{ form.employee_phone }}</td></label
                    >
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-10 col-form-label hkf_text_print"
                      ><td
                        class="td_label_info"
                        style="font-size: 1.2em; font-weight: bold"
                      >
                        Basic Salary:
                      </td>
                      <td class="td_label_data">{{ form.basic_salary }}</td></label
                    >
                  </div>
                </div>
              </div>
            </div>
             <div class="form-group mx-sm-3 col-md-6" v-if="form.cv != ''">
            <label for="location" class="hkf_text">CV File:</label>
            <button
              type="button"
              class="btn action mt-2"
              @click="PrintContent5"
              style="width: 100px"
            >
              Print <i class="fa fa-print pl-2" aria-hidden="true"></i>
            </button>

            <embed v-if="docs" :src="Supporting_docs" />
          </div>
            <!-- <div class="form-group" style="margin-left: -1em !important">
              <label
                for="projectName"
                class="col-sm-12 col-form-label hkf_text_print"
                style="font-size: 1.2em; font-weight: bold"
                >Salary Paid:
              </label>
              <div style="display: block">
                <ul>
                  <li
                    v-for="(salary, index) in salary_history"
                    :key="index"
                    class="td_label_info"
                    style="font-size: 1.2em; font-weight: bold; color: black !important"
                  >
                    <div class="col-md-12 row">
                      <div class="col-md-4">
                        <label for="">
                          {{ salary.paid_month }} - {{ salary.paid_year }}
                        </label>
                      </div>
                      <div class="col-md-4">
                        <router-link
                          :to="{ name: 'edit_salary', params: { id: salary.id } }"
                          class="btn btn-primary"
                          >Edit Salary</router-link
                        >
                        <router-link
                          :to="{ name: 'view_salary', params: { id: salary.id } }"
                          class="btn btn-primary ml-3"
                          >View Salary</router-link
                        >
                      </div>
                    </div>
                  </li>
                </ul>
              </div>
            </div> -->
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
        selectedProject: "",
        employee_name: "",
        employee_address: "",
        employee_phone: "",
        employee_designation: "",
        basic_salary: "",
        employee_id: "",

      },
      docs:false,
      salary_history: [],
      project_location: "",
      projects_temp: [],
      Id: "",
      hideLink: false,
    };
  },
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else {
        vm.$router.push({ name: "view_employee" });
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
      this.$router.push({ name: "view_employee", params: { id: this.$route.params.id } });
    },
     PrintContent5() {
      const file = "../" + this.form.cv;
      console.log(file);
      const newWindow = window.open(file);
      newWindow.onload = () => {
        newWindow.print();
        // newWindow.close();
        /* if (newWindow.close()) {
          this.$router.push({
            name: "view_employee",
            params: { id: this.$route.params.id },
          });
        } */
      };
    },
  },
  created() {
    let id = this.$route.params.id;
    this.Id = id;

    axios
      .get("/api/employee/" + id)
      .then(({ data }) => {
        this.form = data;
        this.Supporting_docs = data.cv;
        if(this.Supporting_docs != ""){
            this.docs = true;
        }
        axios
          .get("/api/salary/getSalaryHistory/" + this.form.employee_id)
          .then((res) => {
            this.salary_history = res.data;
          })
          .catch((err) => {
            console.log(err.response);
          });
      })
      .catch((err) => {
        console.log(err.response);
      });
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
