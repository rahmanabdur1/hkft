<template>
  <div class="row">
    <div class="col-md-12 mx-auto">
      <div class="row">
        <div class="col-md-10 mx-auto">
          <form>
            <div id="print-container">
              <h4
                class="hkf_title_print_only"
                style="padding: 0.5rem; color: black; text-align: center"
              >
                Payment History
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
                      Project Name
                    </th>
                    <th style="border: 1px solid black; border-collapse: collapse">
                      Particular Name
                    </th>
                    <th style="border: 1px solid black; border-collapse: collapse">
                      Payment Method
                    </th>

                    <th style="border: 1px solid black; border-collapse: collapse">
                      Installment
                    </th>
                    <th style="border: 1px solid black; border-collapse: collapse">
                      Action
                    </th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="(history, index) in histories" :key='index'>
                    <td style="border: 1px solid black; border-collapse: collapse">
                      {{ history.basic_date }}
                    </td>
                    <td style="border: 1px solid black; border-collapse: collapse">
                      {{ history.supplier_name }}
                    </td>
                    <td style="border: 1px solid black; border-collapse: collapse">
                      {{ history.project }}
                    </td>
                    <td style="border: 1px solid black; border-collapse: collapse">
                      {{ history.product_name }}
                    </td>
                    <td style="border: 1px solid black; border-collapse: collapse">
                      {{ history.selectedPaymentType }}
                    </td>

                    <td style="border: 1px solid black; border-collapse: collapse">
                      {{ history.paid }} tk
                    </td>
                    <td style="border: 1px solid black; border-collapse: collapse">
                      <router-link
                        class="action_success btn mb-1"
                        :to="{
                          name: 'update_receipt_history',
                          params: { id: history.id },
                        }"
                        >Edit</router-link
                      >
                      <button
                        class="action_danger btn"
                        type="button"
                        @click="deleteEntry(history.id)"
                      >
                        Delete
                      </button>
                    </td>
                  </tr>

                  <!-- add more rows as needed -->
                </tbody>
              </table>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      avatar: "logo.png",
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
      },
      histories: [],
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
      } else {
        vm.$router.push({ name: "edit_receipt_history" });
      }
    });
  },
  methods: {
    deleteEntry(id) {
           Swal.fire({
  title: 'Are you sure?',
  text: "You won't be able to revert this!",
  icon: 'warning',
  showCancelButton: true,
  confirmButtonColor: '#3085d6',
  cancelButtonColor: '#d33',
  confirmButtonText: 'Yes, delete it!'
}).then((result) => {
  if (result.isConfirmed) {

    axios
        .delete("/api/delete_receipt/" + id)
        .then((res) => {
          this.histories = this.histories.filter((item)=>{
               return item.id!= id;
          })
        })
        .catch((err) => {
          console.log(err.response);
        });

    Swal.fire(
      'Deleted!',
      'Your file has been deleted.',
      'success'
    )
  }
})

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
        name: "edit_receipt_history",
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
            name: "edit_receipt_history",
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
      .get("/api/receipt_history_view/" + id)
      .then(({ data }) => {
        this.histories = data;
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
