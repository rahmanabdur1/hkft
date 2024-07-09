<template>
  <div class="row">
    <div class="col-md-12 mx-auto">
      <h2 class="hkf_title mb-2">
        Receipt Voucher: <span>{{ form.receipt_id }}</span>
      </h2>
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

          <div id="print-container">

          <div style='display:flex;border-bottom:1px solid black;' class='mb-3' >
          <div class="sidebar-brand-icon" style='text-align:left;width:20%;'>
        <img class="logo" :src="'../img/'+avatar" style='width:165%;height:77%;' alt="" />
      </div>
       <div style='padding:5%;width:80%;'>
        <h3 style="text-align: center;">HKF Real Estate LTD</h3>
              <h4 style="text-align: center">
                117/2/8 1st Floor Sopnodanga Residential Area<br>
                Phone: 01400407270  <br>    Email:contact@hkf-re.com <br>
                Website: www.hkf-re.com
              </h4>
      </div>
      </div>
  <h1
              style="
                text-align: center;
                font-weight: bold;
                margin-top: 1.5rem;
                margin-bottom: 2rem;
              "
            >
            <span>{{ form.selectedProject }}</span>
            </h1>
            <h3 style="text-align: center">Cash Receipt</h3>
            <h3 style="text-align: center; font-weight: bold; margin-top: 1rem">
              FY : {{ form.financialYear }}
            </h3>
            <h5 style="text-align: right">Receipt ID: {{ form.receipt_id }}</h5>
            <h5 style="text-align: right">Date: {{ form.basic_date }}</h5>
            <table
              style="
                width: 100%;
                border: 1px solid black;
                border-collapse: collapse;
                margin-bottom: 1.5rem;
              "
            >
              <tr
                style="
                  padding: 1.5rem;
                  border: 1px solid black;
                  border-collapse: collapse;
                "
              >
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 24%;
                  "
                >
                  Depositor's Name
                </td>
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 2%;
                  "
                >
                  :
                </td>
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 24%;
                  "
                >
                  {{ form.client_name }}
                </td>
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 50%;
                  "
                >
                 Client ID:<span style="margin-left: 1rem">{{ form.client_id }}</span>
                </td>
              </tr>
              <tr style="border: 1px solid black; border-collapse: collapse">
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 24%;
                  "
                >
                  Address
                </td>
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 2%;
                  "
                >
                  :
                </td>
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 24%;
                  "
                >
                  {{ selectedClient.temprorary_location }}
                </td>
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 50%;
                  "
                >
                  Project Name:<span style="margin-left: 1rem">{{
                    form.selectedProject
                  }}</span>
                </td>
              </tr>
              <tr style="border: 1px solid black; border-collapse: collapse">
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 24%;
                  "
                >
                  Mobile No
                </td>
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 2%;
                  "
                >
                  :
                </td>
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 24%;
                  "
                >
                  {{ selectedClient.phone }}
                </td>
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;
                    width: 50%;
                  "
                >
                  Email:<span style="margin-left: 1rem">{{ selectedClient.email }}</span>
                </td>
              </tr>
            </table>
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
                <th style="border: 1px solid black; text-align: center">Account Code</th>
                <th style="border: 1px solid black; text-align: center">Amount(TK)</th>
              </tr>
              <tr style="height: 135px">
                <td style="border: 1px solid black; text-align: center">
                  <span style="display: block; margin-left: 1rem; font-weight: bold"
                    >Received:</span
                  >
                    <span style="display: block; margin-left: 1rem; font-weight: 300" v-if='form.building_name'
                    >Building : {{form.building_name}} ({{form.selected_label}} : {{ form.product_name }} )</span
                  >
                  <span style="display: block; margin-left: 1rem; font-weight: 300" v-else
                    >Land : ( {{ form.product_name }} )</span
                  >
                </td>
                <td style="border: 1px solid black; text-align: center" v-if='type_bank'>
                <span>Your Bank Account:</span>
                {{form.cash_bank_account}}
                </td>
                <td style="border: 1px solid black; text-align: center" v-if='type_cash'>
                <span>Cash In Hand</span>

                </td>
                <td style="border: 1px solid black; text-align: center">
                  <li  class='receiveAmounts' style='list-style:none'>{{form.product_amount}} tk </li>
                </td>
              </tr>
              <tr style="height: 50px">
                <td style="border: 1px solid black; text-align: center">
                  Received (in word) = {{word}} Taka Only
                </td>
                                <td style="border: 1px solid black; text-align: center">Due: {{form.due}} tk</td>

                <td style="border: 1px solid black; text-align: center">
                  {{total}} Taka
                </td>
              </tr>
            </table>
            <h5>Note: {{ form.payment_receipt_details }}</h5>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "print_voucher",
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else if (User.getGuard() == "manager") {
         axios.get("/api/fetch_access/" + User.getUserName()).then((res) => {
          if (User.getUserName() != res.data.manager_name) {
            vm.$router.push({ name: "manager_dashboard" });
          }
        });
      } else {
        vm.$router.push({ name: "print_voucher" });
      }
    });
  },
  data() {
    return {
        avatar:'logo.png',
      form: {
        Supporting_docs: "",
        bank_branch: "",
        bank_cheque_date: "",
        bank_cheque_no: "",
        bank_name: "",
        basic_date: "",
        cash_bank_account: "",
        client_email: "",
        client_name: "",
        client_phone: "",
        client_tin: "",
        financialYear: "",
        payees_account_no: "",
        payto: "",
        product_name: "",
        receipt_id: "",
        selectedPaymentType: "",
        selectedProject: "",
        total_amount: "",
        client_id: "",
        payment_receipt_details: "",
      },
      allClients: [],
      mergeReceipt: {
        accountHeads: "",
        receiveAmounts: "",
      },
      selectedClient: {
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
      account_heads: "",
      receiveAmounts: "",
      project_location: "",
      total: "",
      projects_temp: [],
      number: "",
      word: "",
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
  methods: {
    printContent() {
      setTimeout(() => {
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
        this.$router.push({ name: "all_voucher" });
      }, 2000);
    },
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

        word = this.tens[number % 10] + " " + word;
        number = Math.floor(number / 10);
      }

      if (number > 0) {
        word = this.ones[number] + " hundred " + word;
      }

      return word;
    },
  },
  created() {
    let id = this.$route.params.id;
    axios
      .get("/api/receipt_voucher/" + id)
      .then((res) => {
        this.form = res.data;
        this.total = parseFloat(parseFloat(this.form.total_amount).toFixed(2));
        this.number = parseInt(this.form.total_amount);
        this.convertToWord();
        if (this.form.selectedPaymentType == "Cheque") {
          this.type_bank = true;
        } else if (this.form.selectedPaymentType == "Cash") {
          this.type_cash = true;
        }

      })
      .catch((err) => {
      });


    axios
      .get("/api/client")
      .then((res) => {
        this.allClients = res.data;
        axios
          .get("/api/client_info/" + this.form.client_id)
          .then(({ data }) => {
            this.selectedClient = data;
          })
          .catch((err) => {
          });
      })
      .catch((err) => {
      });

    axios
      .get("/api/receipt_voucher_single/" + id)
      .then((res) => {
        this.mergeReceipt = res.data;
        this.account_heads = this.mergeReceipt.accountHeads.split(",");
        this.receiveAmounts = this.mergeReceipt.receiveAmounts.split(",");
      })
      .catch((err) => {
      });
    this.convertToWord();
    this.convertLessThanOneThousand();
    this.printContent();
  },
};
</script>
<style>
h1,
h2,
h3,
h4,
h5,
h6 {
  color: black;
}
.accountHeads {
  color: #473b5edb;
  font-size: 1em;
}
.receiveAmounts {
  color: white;
  font-size: 1em;
}
</style>
