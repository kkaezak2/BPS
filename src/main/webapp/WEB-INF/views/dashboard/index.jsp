<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>BitPremiumSystem_DashBoard</title>
<link rel="icon" type="image/x-icon" href="/resources/images/favicon.ico">
<link href="https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2112@1.0/establishRetrosansOTF.woff" rel="stylesheet" />
<link rel="stylesheet" href="/resources/css/tailwind.css" />
<script src="https://cdn.jsdelivr.net/gh/alpine-collective/alpine-magic-helpers@0.5.x/dist/component.min.js"></script>
<script src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.7.3/dist/alpine.min.js" defer></script>

<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.0/dist/cerulean/bootstrap.min.css">
<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/b1f4a63a6f.js" crossorigin="anonymous"></script>
</head>

<body>
<div x-data="setup()" x-init="$refs.loading.classList.add('hidden'); setColors(color);" :class="{ 'dark': isDark}">
<div class="flex h-screen antialiased text-gray-900 bg-gray-100 dark:bg-dark dark:text-light">
<!-- Loading screen -->
<div x-ref="loading" class="fixed inset-0 z-50 flex items-center justify-center text-2xl font-semibold text-white bg-primary-darker">Loading.....</div>

		<div class="flex-1 h-full overflow-x-hidden overflow-y-auto" id="body-bgcolor">

<!-- Navbar -->

<header class="relative bg-white dark:bg-darker">
	<div class="flex items-center justify-between p-2 border-b dark:border-primary-darker" id="headerDiv">

	<!-- Brand -->
	 <div class="flex items-left">
	<a href="/main" class="inline text-2xl font-bold tracking-wider uppercase text-primary-dark dark:text-light" id="alink">
	 <i class="fa-solid fa-house" title="Go BPS :)">&nbsp;</i></a>
	  
	 <a href="" class="inline text-2xl font-bold tracking-wider uppercase text-primary-dark dark:text-light" id="alink2" title="DashBoard">DashBoard</a>
</div>
 <!--  <script>
   
  </script> -->


	<!-- Desktop Right buttons -->
	<nav aria-label="Secondary" class="hidden space-x-2 md:flex md:items-center">

		<!-- Toggle dark theme button -->
	 <button aria-hidden="true" class="relative focus:outline-none"
			x-cloak onclick="modeLightDark()">
	<div
		class="w-12 h-6 transition rounded-full outline-none bg-primary-100 dark:bg-primary-lighter"></div>
		
	<div
		class="absolute top-0 left-0 inline-flex items-center justify-center w-6 h-6 transition-all duration-150 transform scale-110 rounded-full shadow-sm"
		:class="{ 'translate-x-0 -translate-y-px  bg-white text-primary-dark': !isDark, 'translate-x-6 text-primary-100 bg-primary-darker': isDark }">
		<svg x-show="!isDark" class="w-4 h-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
         <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z" />
       </svg>
		<svg x-show="isDark" class="w-4 h-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
         <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z" />
       </svg>
	</div>
	</button> 



		<!-- Settings button -->

		<button @click="openSettingsPanel"
			class="p-2 transition-colors duration-200 rounded-full text-primary-lighter bg-primary-50 hover:text-primary hover:bg-primary-100 dark:hover:text-light dark:hover:bg-primary-dark dark:bg-dark focus:outline-none focus:bg-primary-100 dark:focus:bg-primary-dark focus:ring-primary-darker">
			<span class="sr-only">Open settings panel</span>
			<svg class="w-7 h-7" xmlns="http://www.w3.org/2000/svg"
				fill="none" viewBox="0 0 24 24" stroke="currentColor"
				aria-hidden="true">
               <path stroke-linecap="round" stroke-linejoin="round"
					stroke-width="2"
					d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
               <path stroke-linecap="round" stroke-linejoin="round"
					stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
             </svg>
		</button>

		<!-- User avatar button -->

		<div class="relative" x-data="{ open: false }">

			<!-- User dropdown menu -->

		</div>
</nav>

						<!-- Mobile sub menu -->
						<nav
							x-transition:enter="transition duration-200 ease-in-out transform sm:duration-500"
							x-transition:enter-start="-translate-y-full opacity-0"
							x-transition:enter-end="translate-y-0 opacity-100"
							x-transition:leave="transition duration-300 ease-in-out transform sm:duration-500"
							x-transition:leave-start="translate-y-0 opacity-100"
							x-transition:leave-end="-translate-y-full opacity-0"
							x-show="isMobileSubMenuOpen"
							@click.away="isMobileSubMenuOpen = false"
							class="absolute flex items-center p-4 bg-white rounded-md shadow-lg dark:bg-darker top-16 inset-x-4 md:hidden"
							aria-label="Secondary">
							<div class="space-x-2">

								<!-- Toggle dark theme button -->


								<button aria-hidden="true" class="relative focus:outline-none"
									x-cloak @click="toggleTheme">
									<div
										class="w-12 h-6 transition rounded-full outline-none bg-primary-100 dark:bg-primary-lighter"></div>
									<div
										class="absolute top-0 left-0 inline-flex items-center justify-center w-6 h-6 transition-all duration-200 transform scale-110 rounded-full shadow-sm"
										:class="{ 'translate-x-0 -translate-y-px  bg-white text-primary-dark': !isDark, 'translate-x-6 text-primary-100 bg-primary-darker': isDark }">
										<svg x-show="!isDark" class="w-4 h-4"
											xmlns="http://www.w3.org/2000/svg" fill="none"
											viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round"
												stroke-linejoin="round" stroke-width="2"
												d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z" />
                      </svg>
										<svg x-show="isDark" class="w-4 h-4"
											xmlns="http://www.w3.org/2000/svg" fill="none"
											viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round"
												stroke-linejoin="round" stroke-width="2"
												d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z" />
                      </svg>
									</div>

								</button>



								<!-- Settings button -->

								<button
									@click="openSettingsPanel(); $nextTick(() => { isMobileSubMenuOpen = false })"
									class="p-2 transition-colors duration-200 rounded-full text-primary-lighter bg-primary-50 hover:text-primary hover:bg-primary-100 dark:hover:text-light dark:hover:bg-primary-dark dark:bg-dark focus:outline-none focus:bg-primary-100 dark:focus:bg-primary-dark focus:ring-primary-darker">
									<span class="sr-only">Open settings panel</span>
									<svg class="w-7 h-7" xmlns="http://www.w3.org/2000/svg"
										fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round"
											stroke-linejoin="round" stroke-width="2"
											d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
                      <path stroke-linecap="round"
											stroke-linejoin="round" stroke-width="2"
											d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                    </svg>
								</button>
							</div>

							<!-- User avatar button -->

							<div class="relative ml-auto" x-data="{ open: false }">

								<!-- User dropdown menu -->


							</div>
						</nav>
					</div>


				</header>

				<!-- Main content -->
				<main>
					<!-- Content header -->



					<!-- Content -->
					<div class="mt-2">
						<!-- State cards -->


						<!-- Charts -->

						<div
							class="grid grid-cols-1 p-4 space-y-8 lg:gap-8 lg:space-y-0 lg:grid-cols-3">
							<!-- Bar chart card -->
							<div class="col-span-2 bg-white rounded-md dark:bg-darker"
								x-data="{ isOn: false }" id="border-for-chartdiv">
								<!-- Card header -->
								<div
									class="flex items-center justify-between p-4 border-b dark:border-primary">
									<h4 class="text-lg font-semibold text-gray-500 dark:text-light"
										id="title-for-chart">상품별 계속보험료<span class="fs-6">(직전 6개월 기준)</span></h4>
									<span class="fs-6 text-end" id="unit-css">[단위 : 백만원]</span>

									
								</div>
								<!-- Chart -->
								<div class="relative p-4 h-72">
									<canvas id="barChart"></canvas>
								</div>
							</div>

							<!-- Doughnut chart card -->
							<div class="bg-white rounded-md dark:bg-darker"
								x-data="{ isOn: false }" id="border-for-chartdiv">
								<!-- Card header -->
								<div
									class="flex items-center justify-between p-4 border-b dark:border-primary">
									<h4 class="text-lg font-semibold text-gray-500 dark:text-light"
										id="title-for-chart">납입방법별 비중</h4>
										<span class="fs-6 text-end" id="unit-css">[단위 : %]</span>
									<!-- <div class="flex items-center"> -->
									
							
								</div>
								<!-- Chart -->
								<div class="relative p-4 h-72">
									<canvas id="doughnutChart"></canvas>
								</div>
							</div>
						</div>

						<!-- Two grid columns -->
						<div
							class="grid grid-cols-1 p-4 space-y-8 lg:gap-8 lg:space-y-0 lg:grid-cols-3">
							<!-- Active users chart -->
							<div class="col-span-1 bg-white rounded-md dark:bg-darker"
								id="border-for-chartdiv">
								<!-- Card header -->
								<div class="p-4 border-b dark:border-primary">
									<h4 class="text-lg font-semibold text-gray-500 dark:text-light"
										id="title-for-chart">인별 처리 건수<span class="fs-6 text-end" id="unit-css">[단위 : 건]</span></h4>
										
								</div>
								
								<p class="p-4">
									<span
										class="text-2xl font-medium text-gray-500 dark:text-light"
										id="usersCount">0</span> <span
										class="text-sm font-medium text-gray-500 dark:text-primary">건</span>
								</p>
								<!-- Chart -->
								<div class="relative p-4">
									<canvas id="activeUsersChart"></canvas>
								</div>
							</div>

							<!-- Line chart card -->
							<div class="col-span-2 bg-white rounded-md dark:bg-darker"
								x-data="{ isOn: false }" id="border-for-chartdiv">
								<!-- Card header -->

								<div
									class="flex items-center justify-between p-4 border-b dark:border-primary">
									<h4 class="text-lg font-semibold text-gray-500 dark:text-light"
										id="title-for-chart">월별 계속보험료</h4>


									<form class="d-flex" action="/dashboard/index" method="post">
										<input class="form-control me-sm-2 border" type="date"
											name="startDate" id="startDate"> <input
											class="form-control me-sm-2 border" type="date"
											name="endDate" id="endDate">
										<button class="btn bg-dark text-white" type="submit">조회</button>

									</form>

									<span class="fs-6 text-end" id="unit-css">[단위 : 백만원]</span>
								
								</div>



								<!-- Chart -->
								<div class="relative p-4 h-72">
									<canvas id="lineChart"></canvas>
								</div>
							</div>
						</div>
					</div>
				</main>

			</div>

			<!-- Panels -->

			<!-- Settings Panel -->
			<!-- Backdrop -->

			<div x-transition:enter="transition duration-300 ease-in-out"
				x-transition:enter-start="opacity-0"
				x-transition:enter-end="opacity-100"
				x-transition:leave="transition duration-300 ease-in-out"
				x-transition:leave-start="opacity-100"
				x-transition:leave-end="opacity-0" x-show="isSettingsPanelOpen"
				@click="isSettingsPanelOpen = false"
				class="fixed inset-0 z-10 bg-primary-darker" style="opacity: 0.5"
				aria-hidden="true"></div>


			<!-- Panel -->

			<section
				x-transition:enter="transition duration-300 ease-in-out transform sm:duration-500"
				x-transition:enter-start="translate-x-full"
				x-transition:enter-end="translate-x-0"
				x-transition:leave="transition duration-300 ease-in-out transform sm:duration-500"
				x-transition:leave-start="translate-x-0"
				x-transition:leave-end="translate-x-full" x-ref="settingsPanel"
				tabindex="-1" x-show="isSettingsPanelOpen"
				@keydown.escape="isSettingsPanelOpen = false"
				class="fixed inset-y-0 right-0 z-20 w-full max-w-xs bg-white shadow-xl dark:bg-darker dark:text-light sm:max-w-md focus:outline-none"
				aria-labelledby="settinsPanelLabel">
				<div class="absolute left-0 p-2 transform -translate-x-full">


					<!-- Close button -->


					<button @click="isSettingsPanelOpen = false"
						class="p-2 text-white rounded-md focus:outline-none focus:ring">
						<svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg"
							fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round"
								stroke-width="2" d="M6 18L18 6M6 6l12 12" />
              </svg>
					</button>
				</div>


				<!-- Panel content -->


				<div class="flex flex-col h-screen">


					<!-- Panel header -->

					<div
						class="flex flex-col items-center justify-center flex-shrink-0 px-4 py-8 space-y-4 border-b dark:border-primary-dark">
						<span aria-hidden="true" class="text-gray-500 dark:text-primary">
							<svg class="w-8 h-8" xmlns="http://www.w3.org/2000/svg"
								fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round"
									stroke-width="2"
									d="M12 6V4m0 2a2 2 0 100 4m0-4a2 2 0 110 4m-6 8a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4m6 6v10m6-2a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4" />
                </svg>
						</span>
						<h2 id="settinsPanelLabel"
							class="text-xl font-medium text-gray-500 dark:text-light">Settings</h2>
					</div>
					<!-- Content -->

					<div class="flex-1 overflow-hidden hover:overflow-y-auto">
				

						<!-- Colors -->
						<div class="p-4 space-y-4 md:p-8">
							<h6 class="text-lg font-medium text-gray-400 dark:text-light">Colors</h6>
							<div>
								<button @click="setColors('cyan')"
									class="w-10 h-10 rounded-full"
									style="background-color: var(--color-cyan)"></button>
								<button @click="setColors('teal')"
									class="w-10 h-10 rounded-full"
									style="background-color: var(--color-teal)"></button>
								<button @click="setColors('green')"
									class="w-10 h-10 rounded-full"
									style="background-color: var(--color-green)"></button>
								<button @click="setColors('fuchsia')"
									class="w-10 h-10 rounded-full"
									style="background-color: var(--color-fuchsia)"></button>
								<button @click="setColors('blue')"
									class="w-10 h-10 rounded-full"
									style="background-color: var(--color-blue)"></button>
								<button @click="setColors('violet')"
									class="w-10 h-10 rounded-full"
									style="background-color: var(--color-violet)"></button>
							</div>
						</div>
					</div>
				</div>
			</section>

			<!-- Notification panel -->
			<!-- Backdrop -->

			<div x-transition:enter="transition duration-300 ease-in-out"
				x-transition:enter-start="opacity-0"
				x-transition:enter-end="opacity-100"
				x-transition:leave="transition duration-300 ease-in-out"
				x-transition:leave-start="opacity-100"
				x-transition:leave-end="opacity-0" x-show="isNotificationsPanelOpen"
				@click="isNotificationsPanelOpen = false"
				class="fixed inset-0 z-10 bg-primary-darker" style="opacity: 0.5"
				aria-hidden="true"></div>

			<!-- Panel -->

			<section
				x-transition:enter="transition duration-300 ease-in-out transform sm:duration-500"
				x-transition:enter-start="-translate-x-full"
				x-transition:enter-end="translate-x-0"
				x-transition:leave="transition duration-300 ease-in-out transform sm:duration-500"
				x-transition:leave-start="translate-x-0"
				x-transition:leave-end="-translate-x-full"
				x-ref="notificationsPanel" x-show="isNotificationsPanelOpen"
				@keydown.escape="isNotificationsPanelOpen = false" tabindex="-1"
				aria-labelledby="notificationPanelLabel"
				class="fixed inset-y-0 z-20 w-full max-w-xs bg-white dark:bg-darker dark:text-light sm:max-w-md focus:outline-none">
				<div class="absolute right-0 p-2 transform translate-x-full">


					<!-- Close button -->


					<button @click="isNotificationsPanelOpen = false"
						class="p-2 text-white rounded-md focus:outline-none focus:ring">
						<svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg"
							fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round"
								stroke-width="2" d="M6 18L18 6M6 6l12 12" />
              </svg>
					</button>

				</div>
				<div class="flex flex-col h-screen"
					x-data="{ activeTabe: 'action' }">

					<!-- Panel header -->



					<!-- Panel content (tabs) -->

					<div class="flex-1 pt-4 overflow-y-hidden hover:overflow-y-auto">


						<!-- User tab -->


					</div>
				</div>
			</section>

			<!-- Search panel -->
			<!-- Backdrop -->

			<div x-transition:enter="transition duration-300 ease-in-out"
				x-transition:enter-start="opacity-0"
				x-transition:enter-end="opacity-100"
				x-transition:leave="transition duration-300 ease-in-out"
				x-transition:leave-start="opacity-100"
				x-transition:leave-end="opacity-0" x-show="isSearchPanelOpen"
				@click="isSearchPanelOpen = false"
				class="fixed inset-0 z-10 bg-primary-darker" style="opacity: 0.5"
				aria-hidden="ture"></div>


		</div>
		</section>
	</div>
	</div>

	
	<script
		src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.bundle.min.js"></script>

	<script src="/resources/js/script.js"></script>
	<script>
 
      const setup = () => {
  
        const getTheme = () => {
          if (window.localStorage.getItem('dark')) {
            return JSON.parse(window.localStorage.getItem('dark'))
          }

          return !!window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches
        }

        const setTheme = (value) => {
          window.localStorage.setItem('dark', value)
        }

        const getColor = () => {
          if (window.localStorage.getItem('color')) {
            return window.localStorage.getItem('color')
          }
          return 'cyan'
        }

        const setColors = (color) => {
          const root = document.documentElement
          root.style.setProperty('--color-primary', `var(--color-${color})`)
          root.style.setProperty('--color-primary-50', `var(--color-${color}-50)`)
          root.style.setProperty('--color-primary-100', `var(--color-${color}-100)`)
          root.style.setProperty('--color-primary-light', `var(--color-${color}-light)`)
          root.style.setProperty('--color-primary-lighter', `var(--color-${color}-lighter)`)
          root.style.setProperty('--color-primary-dark', `var(--color-${color}-dark)`)
          root.style.setProperty('--color-primary-darker', `var(--color-${color}-darker)`)
          this.selectedColor = color
          window.localStorage.setItem('color', color)
          //
        }

        const updateBarChart = (on) => {
          const data = {
            data: valueList,
            backgroundColor: 'rgb(207, 250, 254)',
          }
          if (on) {
            barChart.data.datasets.push(data)
            barChart.update()
          } else {
            barChart.data.datasets.splice(1)
            barChart.update()
          }
        }

        const updateDoughnutChart = (on) => {
          const data = random()
          const color = 'rgb(207, 250, 254)'
          if (on) {
            doughnutChart.data.labels.unshift('Seb')
            doughnutChart.data.datasets[0].data.unshift(data)
            doughnutChart.data.datasets[0].backgroundColor.unshift(color)
            doughnutChart.update()
          } else {
            doughnutChart.data.labels.splice(0, 1)
            doughnutChart.data.datasets[0].data.splice(0, 1)
            doughnutChart.data.datasets[0].backgroundColor.splice(0, 1)
            doughnutChart.update()
          }
        }

        const updateLineChart = () => {
          lineChart.data.datasets[0].data.reverse()
          lineChart.update()
        }

        return {
          loading: true,
          isDark: getTheme(),
          toggleTheme() {
            this.isDark = !this.isDark
            setTheme(this.isDark)
          },
          setLightTheme() {
            this.isDark = false
            setTheme(this.isDark)
          },
          setDarkTheme() {
            this.isDark = true
            setTheme(this.isDark)
          },
          color: getColor(),
          selectedColor: 'cyan',
          setColors,
          toggleSidbarMenu() {
            this.isSidebarOpen = !this.isSidebarOpen
          },
          isSettingsPanelOpen: false,
          openSettingsPanel() {
            this.isSettingsPanelOpen = true
            this.$nextTick(() => {
              this.$refs.settingsPanel.focus()
            })
          },
          isNotificationsPanelOpen: false,
          openNotificationsPanel() {
            this.isNotificationsPanelOpen = true
            this.$nextTick(() => {
              this.$refs.notificationsPanel.focus()
            })
          },
          isSearchPanelOpen: false,
          openSearchPanel() {
            this.isSearchPanelOpen = true
            this.$nextTick(() => {
              this.$refs.searchInput.focus()
            })
          },
          isMobileSubMenuOpen: false,
          openMobileSubMenu() {
            this.isMobileSubMenuOpen = true
            this.$nextTick(() => {
              this.$refs.mobileSubMenu.focus()
            })
          },
          isMobileMainMenuOpen: false,
          openMobileMainMenu() {
            this.isMobileMainMenuOpen = true
            this.$nextTick(() => {
              this.$refs.mobileMainMenu.focus()
            })
          },
          updateBarChart,
          updateDoughnutChart,
          updateLineChart,
        }
      }
      
     
    </script>

	<script type="text/javascript">
	var jsonData = ${json}; 
    var jsonObject = JSON.stringify(jsonData);
    var jData = JSON.parse(jsonObject);
    
    // 건수
    var labelList = new Array();
    var valueList = new Array();
    var labelList2 = new Array();
    var valueList2 = new Array();
    var labelList3 = new Array();
    var valueList3 = new Array();
    // 보험료
    var labelList4 = new Array();
    var valueList4 = new Array();    
    var labelList5 = new Array();
    var valueList5 = new Array();
    
    
    
   
        for(var i = 0; i<jData.length; i++) {
    	var d = jData[i];
    	
    	 if (d.processDate) {
    		labelList.push(d.processDate);
    		valueList.push(d.count);
    	 }
    	 
    	 if (d.name) {
    		labelList2.push(d.name);
    	    valueList2.push(d.count2);
    	  }
    	 
    	 if (d.method) {
     		labelList3.push(d.method);
     	    valueList3.push(d.count3);
     	  }
    	 
    	 if (d.product) {
      		labelList4.push(d.product);
      	    valueList4.push(d.premium);
      	  }
    	 
    	 if (d.month) {
       		labelList5.push(d.month);
       	    valueList5.push(d.premium2);
       	  }
    }
      
    
    generateActiveUsersChart(labelList2, valueList2); // 인별 처리 건수
  	generateBarChart(labelList4, valueList4); // 상품별 보험료
    generateDoughnutChart(labelList3, valueList3); // 납입방법별 비중   
    generateLineChart(labelList5, valueList5); // 월별 보험료  
    
    </script>


</body>
</html>