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
              <h4
                class="hkf_title_print_only"
                style="padding: 0.5rem; color: black; text-align: center"
              >
                Expense Details:
              </h4>

              <div class="row rowPhotoDiv">
                <div class="col-md-8 colPhotoDiv">
                  <div class="form-group row">
                    <label class="col-sm-6 col-form-label hkf_text_print"
                      ><td class="td_label_info" style='font-size:1.2em;font-weight:bold;'>Financial Year:</td>
                      <td class="td_label_data">{{ form.financialYear }}</td>
                    </label>
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-6 col-form-label hkf_text_print"
                      ><td class="td_label_info"  style='font-size:1.2em;font-weight:bold;'>Date:</td>
                      <td class="td_label_data">{{ form.basic_date }}</td></label
                    >
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-6 col-form-label hkf_text_print"
                      ><td class="td_label_info"  style='font-size:1.2em;font-weight:bold;'>Project:</td>
                      <td class="td_label_data">{{ form.selectedProject }}</td></label
                    >
                  </div>
                   <div class="form-group row">
                    <label class="col-sm-6 col-form-label hkf_text_print"
                      ><td class="td_label_info"  style='font-size:1.2em;font-weight:bold;'>Building:</td>
                      <td class="td_label_data">{{ form.building_name }}</td></label
                    >
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-6 col-form-label hkf_text_print"
                      ><td class="td_label_info"  style='font-size:1.2em;font-weight:bold;'>Payment Type:</td>
                      <td class="td_label_data">{{ form.selectedPaymentType }}</td></label
                    >
                  </div>
                  <div class="form-group row" v-if="form.bank_name">
                    <label class="col-sm-6 col-form-label hkf_text_print"
                      ><td class="td_label_info"  style='font-size:1.2em;font-weight:bold;'>Bank Name:</td>
                      <td class="td_label_data">{{ form.bank_name }}</td></label
                    >
                  </div>
                  <div class="form-group row" v-if="form.bank_branch">
                    <label class="col-sm-6 col-form-label hkf_text_print"
                      ><td class="td_label_info"  style='font-size:1.2em;font-weight:bold;'>Bank Branch:</td>
                      <td class="td_label_data">{{ form.bank_branch }}</td></label
                    >
                  </div>
                  <div class="form-group row" v-if="form.cash_bank_account">
                    <label class="col-sm-6 col-form-label hkf_text_print"
                      ><td class="td_label_info"  style='font-size:1.2em;font-weight:bold;'>Bank Account:</td>
                      <td class="td_label_data">{{ form.cash_bank_account }}</td></label
                    >
                  </div>
                  <div class="form-group row" v-if="form.bank_cheque_no">
                    <label class="col-sm-6 col-form-label hkf_text_print"
                      ><td class="td_label_info"  style='font-size:1.2em;font-weight:bold;'>Cheque:</td>
                      <td class="td_label_data">{{ form.bank_cheque_no }}</td></label
                    >
                  </div>
                  <div class="form-group row" v-if="form.bank_cheque_date">
                    <label class="col-sm-6 col-form-label hkf_text_print"
                      ><td class="td_label_info"  style='font-size:1.2em;font-weight:bold;'>Cheque Date:</td>
                      <td class="td_label_data">{{ form.bank_cheque_date }}</td></label
                    >
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-6 col-form-label hkf_text_print"
                      ><td class="td_label_info" style='font-size:1.2em;font-weight:bold;'>Cost Purpose:</td>
                      <td class="td_label_data">{{ form.product_name }}</td></label
                    >
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-6 col-form-label hkf_text_print"
                      ><td class="td_label_info" style='font-size:1.2em;font-weight:bold;'>Cost:</td>
                      <td class="td_label_data">{{ form.receive_amount }}Tk</td></label
                    >
                  </div>
                    <div class="form-group row">
                    <label class="col-sm-6 col-form-label hkf_text_print"
                      ><td class="td_label_info" style='font-size:1.2em;font-weight:bold;'>Note:</td>
                      <td class="td_label_data">{{ form.note }}</td></label
                    >
                  </div>
                   <div class="form-group row" v-if="form.Supporting_docs != ''">
            <label  class="col-form-label hkf_text_print"><td class="td_label_info" style='font-size:1.2em;font-weight:bold;'>File:</td></label>
            <button
              type="button"
              class="btn action mt-2"
              @click="PrintContent5"
              style="width: 100px"
            >
              Print 
              <i class="fa fa-print pl-2" aria-hidden="true"></i>
              <i class="fa fa-download pl-2" aria-hidden="true"></i>
            </button>

            <embed v-if="docs" :src="Supporting_docs" type="application/pdf" />
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
      form: {
        financialYear: "",
        basic_date: "",
        selectedPaymentType: "",
        cash_bank_account: "",
        selectedProject: "",
        product_name: "",
        bank_cheque_no: "",
        bank_cheque_date: "",
        bank_name: "",
        bank_branch: "",
        receive_amount: "",
        payment_id: "",
        note:"",
      },
      project_location: "",
      projects_temp: [],
      Id: "",
    };
  },
    beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      }else {
        vm.$router.push({ name: "view_expense" });
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
              body > div > div > div:nth-child(9) {
                display:none;
              }
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
      this.$router.push({ name: "view_expense", params: { id: this.$route.params.id } });
    },
    PrintContent5(){
         const file = "../" + this.form.Supporting_docs;
      const newWindow = window.open(file);
      newWindow.onload = () => {
        newWindow.print();
        // newWindow.close();
        /*
        if (newWindow.close()) {
          this.$router.push({
            name: "view_expense",
            params: { id: this.$route.params.id },
          });
        }
        */
      };
    }
  },
  created() {
    let id = this.$route.params.id;
    this.Id = id;

    if (!User.hasLoggedIn()) {
      this.$router.push({ name: "home" });
    } else {
      this.$router.push({ name: "view_expense" });
    }

    axios
      .get("/api/expense/" + id)
      .then(({ data }) => {
        this.form = data;
      })
      .catch((err) => {
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
