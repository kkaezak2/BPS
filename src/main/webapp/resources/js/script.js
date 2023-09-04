// All javascript code in this project for now is just for demo DON'T RELY ON IT


function modeLightDark() {
  var element = document.body;
  element.classList.toggle("dark-mode");
}
function modeDarkLight() {
  var element = document.body;
  element.classList.toggle("light-mode");
}


let currentIndex = 0;

const sequentialValueWithLabel = () => {
	const value = valueList2[currentIndex];
	const label = labelList2[currentIndex];
	currentIndex = (currentIndex + 1) % valueList2.length;
	return { value, label };
}

const cssColors = (color) => {
	return getComputedStyle(document.documentElement).getPropertyValue(color)
}


const getColor = () => {
	return window.localStorage.getItem('color') || 'cyan';
};



const colors = {
	primary: cssColors(`--color-${getColor()}`),
	primaryLight: cssColors(`--color-${getColor()}-light`),
	primaryLighter: cssColors(`--color-${getColor()}-lighter`),
	primaryDark: cssColors(`--color-${getColor()}-dark`),
	primaryDarker: cssColors(`--color-${getColor()}-darker`),
}


// 바차트
function generateBarChart(labelList4, valueList4) {

	var barChart = new Chart(document.getElementById('barChart'), {
		type: 'bar',
		data: {
			labels: labelList4,
			datasets: [
				{
					data: valueList4,
					backgroundColor: [
						colors.primary,
						colors.primaryDarker,
						colors.primary,
						colors.primaryDarker,
						colors.primary,
						colors.primaryDarker],
					borderRadius: 20,
					hoverBackgroundColor: [
						'rgba(255,224,58,0.7)',
						'rgba(0,0,0,0.7)',
						'rgba(255,224,58,0.7)',
						'rgba(0,0,0,0.7)',
						'rgba(255,224,58,0.7)',
						'rgba(0,0,0,0.7)'
						],
				},
			],
		},
		options: {
			scales: {
				yAxes: [
					{
						gridLines: true,
						display: true,
						ticks: {
							beginAtZero: true,
							stepSize: 1000000,
							fontSize: 12,
							fontColor: '#97a4af',
							fontFamily: 'establishRetrosansOTF',
							padding: 8,
							callback: function(value) {
								return (value / 1000000).toLocaleString() + 'M';
							},

						},
					},
				],
				xAxes: [
					{
						gridLines: false,
						ticks: {
							fontSize: 14,
							fontColor: '#97a4af',
							fontFamily: 'establishRetrosansOTF',
							padding: 5,
						},
						categoryPercentage: 0.5,
						maxBarThickness: '100',
					},
				],
			},
			cornerRadius: 20,
			maintainAspectRatio: false,
			legend: {
				display: false,  // 범례
			},
		},
	})
}

// 차트 전역 설정 변경
Chart.defaults.font.family = 'establishRetrosansOTF'; // 원하는 글꼴로 변경

// 도넛차트
function generateDoughnutChart(labelList3, valueList3) {
	const doughnutChart = new Chart(document.getElementById('doughnutChart'), {
		type: 'doughnut',
		data: {
			labels: labelList3,
			datasets: [
				{
					data: valueList3,
					backgroundColor: [
						colors.primaryLight,
						colors.primaryLighter,
						colors.primary
					],
					hoverBackgroundColor: [
						'rgba(0,0,0,0.5)',
						'rgba(0,0,0,0.5)',
						'rgba(0,0,0,0.5)'
					],
					borderWidth: 1,
					weight: 0.5,
				},
			],
		},
		options: {
			responsive: true,
			maintainAspectRatio: false,
			plugins: {
				legend: {
					position: 'bottom',
					labels: {
						font:{
							family:'establishRetrosansOTF',
						},
					},
				},
			},
			title: {
				display: false,
			},
			animation: {
				animateScale: true,
				animateRotate: true,
			},
		},
	});
}


// 움직이는바차트
function generateActiveUsersChart(labelList2, valueList2) {
	console.log("labelList:", labelList2);
	console.log("valueList:", valueList2);

	const activeUsersChart = new Chart(document.getElementById('activeUsersChart'), {
		type: 'bar',
		data: {
			labels: labelList2,
			datasets: [
				{
					data: valueList2,
					backgroundColor: colors.primary,
					borderWidth: 0,
					categoryPercentage: 1,
				},
			],
		},
		options: {
			scales: {
				yAxes: [
					{
						display: false,
						gridLines: false,
					},
				],
				xAxes: [
					{
						display: false,
						gridLines: false,
					},
				],
				ticks: {
					padding: 10,
				},
			},
			cornerRadius: 2,
			maintainAspectRatio: false,
			legend: {
				display: false,
			},
			tooltips: {
				prefix: 'Users',
				bodySpacing: 4,
				footerSpacing: 4,
				hasIndicator: true,
				mode: 'index',
				intersect: true,
			},
			hover: {
				mode: 'nearest',
				intersect: true,
			},
		},
	})

	let randomUserCount;

	const usersCount = document.getElementById('usersCount')


	const fakeUsersCount = () => {
		const { value: randomUserCount, label } = sequentialValueWithLabel();

		activeUsersChart.data.datasets[0].data.push(randomUserCount);
		activeUsersChart.data.datasets[0].data.splice(0, 1);
		activeUsersChart.data.labels.push(label);
		activeUsersChart.data.labels.splice(0, 1);
		activeUsersChart.update();
		usersCount.innerText = randomUserCount;

	}

	setInterval(() => {
		fakeUsersCount()
	}, 1000)

}

// 라인차트
function generateLineChart(labelList5, valueList5) {

	const lineChart = new Chart(document.getElementById('lineChart'), {
		type: 'line',
		data: {
			labels: labelList5,
			datasets: [
				{
					data: valueList5,
					fill: true,
					borderColor: colors.primary,
					backgroundColor: 'rgba(226,226,226,0.5)',
					borderWidth: 5,
					borderDash: [10, 10],
					pointRadius: 10,
					pointHoverRadius: 15,
					pointBorderColor: 'rgb(0,0,0)',
					/*pointBackgroundColor: 'rgb(255,224,58)',*/
					pointHoverBoderColor: 'rgb(255,224,58)',
					pointHoverBackgroundColor: 'rgb(255,224,58)',
					pointStyle: 'star',
				},
			],
		},
		options: {
			responsive: true,
			scales: {
				yAxes: [
					{
						gridLines: false,
						display: true,
						ticks: {
							beginAtZero: true,
							stepSize: 1000000,
							fontSize: 12,
							fontColor: '#97a4af',
							fontFamily: 'establishRetrosansOTF',
							padding: 50,
							callback: function(value) {
								return (value / 1000000).toLocaleString() + 'M';
							},
						},
					},
				],
				xAxes: [
					{
						gridLines: false,
						ticks: {
							fontSize: 10, // 원하는 크기로 변경
							//align:'start',
							fontColor: '#97A4AF', // 원하는 색상으로 변경
							fontFamily: 'establishRetrosansOTF', // 원하는 글꼴로 변경
							//maxRotation: 30, // 최대 회전 각도 설정 (여기서는 45도)
							//minRotation: 30, // 최소 회전 각도 설정 (여기서는 45도)*/
						},
					},
				],
			},

			maintainAspectRatio: false,
			legend: {
				display: false,
			},
			tooltips: {
				hasIndicator: true,
				intersect: false,
			},
		},
	})
}

