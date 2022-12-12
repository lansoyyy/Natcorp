class Details {
  String about;
  String logoUrl1;
  bool isMark;
  String title1;
  List<String> req1;
  Details(this.about, this.logoUrl1, this.isMark, this.title1, this.req1);
  static List<Details> generatedetails() {
    return [
      Details(
        'About us',
        'assets/images/aboutus.png',
        false,
        'NatCorp was originated last October 1, 2012. ',
        [
          'NatCorp is a company owned and managed by group of young, dynamic, aggressive and experienced core group with expertise in marketing and customer relations and personnel control and staffing. It was originated last October 1, 2012. The collective experience and desire of the company to be a very reliable and dependable source for manpower requirements make us a better alternative in the industry.',
        ],
      ),
      Details(
        'Qualifications',
        'assets/images/qualification.png',
        false,
        'Talent Acqusition Lead',
        [
          'Male and Female',
          'Single or Married',
          'High school or College Graduate',
          'At least 4*11 in Height',
          'With or without Experience',
          'Willing to be assigned at Batangas/Laguna area',
        ],
      ),
      Details(
        'Services',
        'assets/images/services.png',
        false,
        'We will quickly send you our abundant talent',
        [
          'TEMPORARY STAFFING',
          'PROJECT BASED STAFFING',
          'OUTSOURCING',
          'MEDICAL PRE-EMPLOYMENT',
          'JANITORIAL / GENERAL MAINTENANCE SERVICES',
        ],
      ),
      Details(
        'Benefits',
        'assets/images/benefits.png',
        false,
        'We Care for you',
        [
          'SSS',
          'PagIbig',
          'PhilHealth',
          'ASIANCARE',
          'Maternity Leave',
        ],
      ),
      Details(
        'Requirements',
        'assets/images/requirements.png',
        false,
        'Talent Acqusition Lead',
        [
          'NSO Birth Certificate',
          'NBI Clearance',
          'Certificate of Employment (COE)',
          'SSS',
          'PagIbig',
          'PhilHealth',
          'TIN',
          'Transcript of Record (TOR)',
          'Barangay Clearance',
          'Police Clearance',
          'Marriage Contract (If married)',
          'Vaccination Card',
        ],
      ),
      Details(
        'We Offer',
        'assets/images/offers.png',
        false,
        'Talent Acqusition Lead',
        [
          'Free Uniform',
          'Free Medical',
          'Free Medicine',
          'Free Shuttle',
          'Free Accomodation',
          'Healthcard',
          'Monthly and quarterly perfect attendance ',
          'Provide complete government mandatory benifits',
        ],
      ),
    ];
  }
}
