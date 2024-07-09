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
              <h4
                class="hkf_title_print_only"
                style="padding: 0.5rem; color: black; text-align: center"
              >
                Extra Payment History
              </h4>

              <table
                class="table"
                cellspacing="0"
                style="
                  border: 1px solid black;
                  border-collapse: collapse;
                  text-align: center;
                "
              >
                <thead style="border: 1px solid black; border-collapse: collapse">
                  <tr>
                    <th style="border: 1px solid black; border-collapse: collapse">
                      Date
                    </th>
                    <th style="border: 1px solid black; border-collapse: collapse">
                      Client Name
                    </th>
                    <th style="border: 1px solid black; border-collapse: collapse">
                      Client ID
                    </th>
                    <th style="border: 1px solid black; border-collapse: collapse">
                      Project Name
                    </th>
                    <th style="border: 1px solid black; border-collapse: collapse">
                      Building Name
                    </th>
                    <th style="border: 1px solid black; border-collapse: collapse">
                      Amount
                    </th>

                    <th style="border: 1px solid black; border-collapse: collapse">
                      Note
                    </th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="(history, index) in histories">
                    <td style="border: 1px solid black; border-collapse: collapse">
                      {{ history.basic_date }}
                    </td>
                    <td style="border: 1px solid black; border-collapse: collapse">
                      {{ history.client_name }}
                    </td>
                    <td style="border: 1px solid black; border-collapse: collapse">
                      {{ history.client_id }}
                    </td>
                    <td style="border: 1px solid black; border-collapse: collapse">
                      {{ history.selectedProject }}
                    </td>
                    <td style="border: 1px solid black; border-collapse: collapse">
                      {{ history.selectedBuilding }}
                    </td>
                    <td style="border: 1px solid black; border-collapse: collapse">
                      {{ history.amount }} tk
                    </td>

                    <td style="border: 1px solid black; border-collapse: collapse">
                      {{ history.note }}
                    </td>
                  </tr>

                  <!-- add more rows as needed -->
                </tbody>
              </table>
              <div class="col-md-12 text-right">
                <span class="col-md-12 hkf_texts"
                  >Total Amount is : {{ totalAmount }} tk</span
                >
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
      avatar: "logo.png",

      histories: [],
      project_location: "",
      projects_temp: [],
      Id: "",
      totalAmount: 0,
    };
  },
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else if (User.getGuard() == "manager") {
        vm.$router.push({ name: "manager_dashboard" });
      } else {
        vm.$router.push({ name: "view_advance_pay" });
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
      this.$router.push({
        name: "view_advance_pay",
        params: { id: this.$route.params.id },
      });
    },
    PrintContent5() {
      const file = "/" + this.form.Supporting_docs;
      const newWindow = window.open(file);
      newWindow.onload = () => {
        newWindow.print();
        newWindow.close();
        if (newWindow.close()) {
          this.$router.push({
            name: "view_advance_pay",
            params: { id: this.$route.params.id },
          });
        }
      };
    },
  },
  created() {
    let id = this.$route.params.id;
    this.Id = id;

    axios
      .get("/api/getAdvanceById/" + id)
      .then(({ data }) => {
        this.histories = data;
        this.histories.forEach((item) => {
          this.totalAmount += parseInt(item.amount);
        });
      })
      .catch((err) => {});
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
