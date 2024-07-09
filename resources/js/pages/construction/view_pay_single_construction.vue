<template>
  <div class="row paySingle">
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
            <div id="print-container" style="line-height: 3.5">
              <div style="display: flex; border-bottom: 1px solid black" class="mb-3">
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

              <h3 style="text-align: center">Paid Construction Cost</h3>

              <div class="row printHeader" style="display: flex; height: 185px">
                <div class="col colLeft" style="text-align: left">
                  <h5>Depositor's Name:{{ form.client_name }}</h5>
                  <h5>
                    Address :<span v-if="client.temprorary_location !== null">{{
                      client.temprorary_location
                    }}</span
                    ><span v-if="client.temprorary_thana !== null"
                      >,{{ client.temprorary_thana }}</span
                    ><span v-if="client.temprorary_district !== null"
                      >, {{ client.temprorary_district }}</span
                    >
                  </h5>
                  <h5>Mobile No:{{ client.phone }}</h5>
                </div>
                <div class="col colRight" style="text-align: right">
                  <h5>Physical Voucher: {{ form.physical_voucher }}</h5>
                  <h5>Date: {{ form.basic_date }}</h5>
                  <h5>Client ID:{{ form.client_id }}</h5>
                  <h5>Project Name:{{ form.selectedProject }}</h5>
                  <h5>Building Name:{{ form.selectedBuilding }}</h5>
                </div>
              </div>

              <h5 style="text-align: left">Received Details:</h5>
              <table
                style="
                  width: 100%;
                  border: 1px solid black;
                  border-collapse: collapse;
                  margin-bottom: 1.5rem;
                "
              >
                <tr>
                  <th style="border: 1px solid black; text-align: center">
                    Brief Description
                  </th>
                  <th style="border: 1px solid black; text-align: center">
                    Account Code
                  </th>
                  <th style="border: 1px solid black; text-align: center">Amount(TK)</th>
                </tr>
                <tr style="height: 135px">
                  <td style="border: 1px solid black; text-align: center">
                    <span style="display: block; margin-left: 1rem; font-weight: bold"
                      >Purpose:</span
                    >

                    <span style="display: block; margin-left: 1rem; font-weight: 300"
                      >( {{ form.note }} )</span
                    >
                  </td>
                  <td style="border: 1px solid black; text-align: center">
                    <div v-if="type_bank">
                      <span>Your Bank Account : </span>
                      {{ form.cash_bank_account }}
                    </div>
                    <div v-if="type_cash">Cash</div>
                  </td>
                  <td style="border: 1px solid black; text-align: center">
                    <li class="paymentAmounts" style="list-style: none">
                      {{ form.paid_amount }} Taka
                    </li>
                  </td>
                </tr>
                <tr style="height: 50px">
                  <td style="border: 1px solid black; text-align: center">
                    Paid(in word) = {{ word }} Taka Only
                  </td>
                  <td style="border: 1px solid black; text-align: center" colspan="2">
                    Total Paid: {{ totalAmount }} Taka
                  </td>
                </tr>
              </table>

              <div class="row mt-5" style="display: flex">
                <div class="col colLeft" style="width: 100%">
                  <h5 style="width: 50%">
                    {{ form.receieved_by }}
                  </h5>
                  <h5 style="width: 50%; border-top: 1px solid black">Receiver Name</h5>
                </div>
                <div class="col colRight text-right" style="width: 100%">
                  <h5 style="width: 50%" class="mt-4"></h5>
                  <h5
                    style="
                      width: 50%;
                      border-top: 1px solid black;
                      margin-left: 30%;
                      text-align: right;
                    "
                  >
                    Receiver Signature
                  </h5>
                </div>
              </div>
            </div>
          </form>
          <div class="constructionPrint" v-if="hasDocs">
            <h5>Document:</h5>
            <embed :src="'/' + form.Supporting_docs" type="application/pdf" />
            <button
              type="button"
              class="btn action mt-2"
              @click="PrintContent5"
              style="width: 100px; display: block"
            >
              Print <i class="fa fa-print pl-2" aria-hidden="true"></i>
            </button>
          </div>
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
        basic_date: "",
        client_name: "",
        selectedProject: "",
        selectedBuilding: "",
        client_id: "",
        paid_amount: "",
        note: "",
        receieved_by: "",
      },
      word: "",

      number: "",
      histories: [],
      project_location: "",
      projects_temp: [],
      Id: "",
      totalAmount: 0,
      client: {
        temprorary_location: "",
        temprorary_district: "",
        temprorary_post_office: "",
        temprorary_thana: "",
        phone: "",
      },
      hasDocs: false,
      ones: [
        "",
        "One",
        "Two",
        "Three",
        "Four",
        "Five",
        "Six",
        "Seven",
        "Eight",
        "Nine",
        "Ten",
        "Eleven",
        "Twelve",
        "Thirteen",
        "Fourteen",
        "Fifteen",
        "Sixteen",
        "Seventeen",
        "Eighteen",
        "Nineteen",
      ],
      tens: [
        "",
        "",
        "Twenty",
        "Thirty",
        "Forty",
        "Fifty",
        "Sixty",
        "Seventy",
        "Eighty",
        "Ninety",
      ],
      thousands: ["", "Thousand", "Million", "Billion", "Trillion"],
    };
  },
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else {
        vm.$router.push({ name: "view_pay_single_construction" });
      }
    });
  },
  methods: {
    convertToWord() {
      let number = this.number;
      let word = "";

      if (number === 0) {
        word = "zero";
      } else {
        if (number < 0) {
          word = "negative ";
          number = Math.abs(number);
        }

        let i = 0;
        while (number > 0) {
          if (number % 1000 !== 0) {
            word =
              this.convertLessThanOneThousand(number % 1000) +
              " " +
              this.thousands[i] +
              " " +
              word;
          }
          number = Math.floor(number / 1000);
          i++;
        }
      }

      this.word = word.trim();
    },

    convertLessThanOneThousand(number) {
      let word = "";

      if (number % 100 < 20) {
        word = this.ones[number % 100];
        number = Math.floor(number / 100);
      } else {
        word = this.ones[number % 10];
        number = Math.floor(number / 10);

        word = this.tens[number % 10] + word;
        number = Math.floor(number / 10);
      }

      if (number > 0) {
        word = this.ones[number] + "hundred " + word;
      }

      return word;
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
        name: "view_pay_single_construction",
        params: { id: this.$route.params.id },
      });
    },
    PrintContent5() {
      const file = "../" + this.form.Supporting_docs;
      const newWindow = window.open(file);
      console.log(file);
      newWindow.onload = () => {
        newWindow.print();
        // newWindow.close();
      };
    },
  },
  created() {
    let id = this.$route.params.id;
    this.convertToWord();
    this.convertLessThanOneThousand();
    axios
      .get("/api/pay_construction/" + id)
      .then(({ data }) => {
        this.form = data;
        console.log(this.form);
        if (this.form.Supporting_docs) {
          this.hasDocs = true;
        } else {
          this.hasDocs = false;
        }
        axios
          .get("/api/pay_construction_voucher/" + this.form.client_id)
          .then((res) => {
            this.client = res.data;
          })
          .catch((err) => console.log(err.response));
        console.log(this.form);
        this.number = parseInt(this.form.paid_amount);
        this.convertToWord();
        if (this.form.selectedPaymentType == "Cheque") {
          this.type_bank = true;
        } else if (this.form.selectedPaymentType == "Cash") {
          this.type_cash = true;
        }

        axios
          .post("/api/fetch_paid_construction", this.form, {
            headers: {
              "Content-Type": "application/json",
              Accept: "application/json",
            },
          })
          .then((res) => {
            this.histories = res.data;
            this.totalAmount = 0;
            this.histories.forEach((item) => {
              this.totalAmount += parseInt(item.paid_amount);
            });
            console.log(this.histories);
          })
          .catch((err) => {
            console.log(err.response);
          });
        // axios
        //   .post("/api/fetch_paid_construction", this.form, {
        //     headers: {
        //       "Content-Type": "application/json",
        //       Accept: "application/json",
        //     },
        //   })
        //   .then((res) => {
        //     this.histories = res.data;
        //     this.totalAmount = 0;
        //     this.histories.forEach((item) => {
        //       this.totalAmount += parseInt(item.paid_amount);
        //     });
        //     console.log(this.histories);
        //   })
        //   .catch((err) => {
        //     console.log(err.response);
        //   });
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
.colRight {
  text-align: right;
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

@media only screen and (max-width: 850px) {
  .paySingle h1,
  h2,
  h3,
  h4,
  h5,
  h6 {
    font-size: 1em !important;
  }
  .printHeader {
    height: 150px !important;
  }
}
</style>
