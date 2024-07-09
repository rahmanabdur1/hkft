<template>
  <div class="row">
    <div class="input-group col-md-6 page_to_page">
      <router-link :to="{ name: 'all_purchase_land' }" class="btn btn-primary"
        >Land Details</router-link
      >
    </div>
    <div class="col-md-12 mx-auto">
      <div class="row">
        <div class="col-md-8 mx-auto">
          <button
            type="button"
            class="btn action_print mb-3"
            style="margin-left: 85%"
            @click="printContent"
          >
            Print<i class="fa fa-print pl-2" aria-hidden="true"></i>
          </button>

          <form>
            <div id="print-container">
              <h2
                class="hkf_title_print_only"
                style="padding: 0.5rem; color: black; text-align: center"
              >
                ভূমি বিবরণ
              </h2>

              <div class="row rowPhotoDiv">
                <div class="col-md-8 colPhotoDiv">
                  <div class="form-group row">
                    <label class="col-sm-8 col-form-label hkf_text_print"
                      ><td class="td_label_info">ভূমি অফিসের নামঃ</td>
                      <td class="td_label_data">{{ form.land_office }}</td>
                    </label>
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-8 col-form-label hkf_text_print"
                      ><td class="td_label_info">মৌজার/জে. এল. নংঃ</td>
                      <td class="td_label_data">{{ form.moujar }}</td>
                    </label>
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-8 col-form-label hkf_text_print"
                      ><td class="td_label_info">উপজেলা/থানাঃ</td>
                      <td class="td_label_data">{{ form.thana }}</td></label
                    >
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-8 col-form-label hkf_text_print"
                      ><td class="td_label_info">জেলাঃ</td>
                      <td class="td_label_data">{{ form.district }}</td></label
                    >
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-8 col-form-label hkf_text_print"
                      ><td class="td_label_info">মালিকের নামঃ</td>
                      <td class="td_label_data">{{ form.owner_name }}</td></label
                    >
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-8 col-form-label hkf_text_print"
                      ><td class="td_label_info">হোল্ডিং নাম্বারঃ</td>
                      <td class="td_label_data">{{ form.holding_number }}</td></label
                    >
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-8 col-form-label hkf_text_print"
                      ><td class="td_label_info">জমির শ্রেণীঃ</td>
                      <td class="td_label_data">{{ form.land_class }}</td></label
                    >
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-8 col-form-label hkf_text_print"
                      ><td class="td_label_info">খতিয়ান নংঃ</td>
                      <td class="td_label_data">{{ form.ledger_no }}</td></label
                    >
                  </div>
                  <div class="form-group row">
                    <label class="col-sm-8 col-form-label hkf_text_print"
                      ><td class="td_label_info">দাগ নংঃ</td>
                      <td class="td_label_data">{{ form.dag_no }}</td></label
                    >
                  </div>
                </div>
              </div>
            </div>
        <div style='display:flex'>
         <h5>Document:</h5>
          <button
            type="button"
            class="btn action mt-2 ml-3"
            @click="PrintContent5"
            style="width: 100px"
            v-if="form.Supporting_docs != ''"
          >
            Print <i class="fa fa-print pl-2" aria-hidden="true"></i>
          </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "view_purchase_land",
  data() {
    return {
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
        profile_photos: "",
      },
      project_location: "",
      projects_temp: [],
      Id: "",
    };
  },
  methods: {
      PrintContent5() {
      const file = "../" + this.form.Supporting_docs;
      const newWindow = window.open(file);
      newWindow.onload = () => {
        newWindow.print();
        // newWindow.close();
        /*
        if (newWindow.close()) {
          this.$router.push({
            name: "payment_view_voucher",
            params: { id: this.$route.params.id },
          });
        }
        */
      };
    },
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
      this.$router.push({
        name: "view_purchase_land",
        params: { id: this.$route.params.id },
      });
    },
  },
  created() {
    let id = this.$route.params.id;
    this.Id = id;

    if (!User.hasLoggedIn()) {
      this.$router.push({ name: "home" });
    } else if (User.getGuard() == "manager") {
      vm.$router.push({ name: "manager_dashboard" });
    } else {
      this.$router.push({ name: "view_purchase_land" });
    }

    axios
      .get("/api/purchase_land_details/" + id)
      .then(({ data }) => {
        this.form = data;
      })
      .catch((err) => {
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
