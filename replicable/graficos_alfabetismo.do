*Estadísticas descriptivas para alfabetización en el siglo XX y asistencia escolar en el siglo XIX.

*Alfabetizacion S. XX
clear all
cls
import excel  "/Users/casa/Dropbox/00-SCHOOL/1-University/2021-20/1-Historia_Económica_de_Colombia/3-Investigación/8-Datos/migracion_caribe-hec/raw/alfabetismo_con_nombres_sXX.xls", sheet("analfabetismo_sXX") cellrange(A1:I3911) firstrow 
collapse (sum) alfabetismo lalfa, by(depto anho)
egen id_depto=group(depto)
recode alfabetismo 0=.
order id_depto 
sort id_depto
tset id_depto anho, y
label define bolivar 6 "Bolívar"
label values id_depto bolivar
label define magdalena 19 "Magdalena"
label val id_depto magdalenan 
*Generar media nacional
egen national_mean=mean(alfabetismo), by(anho)
gen national_mean_ln=ln(national_mean)
twoway (tsline alfabetismo if id_depto==19) || (tsline alfabetismo if id_depto==6) || (tsline national_mean, lcolor(gs6)), scheme(s2mono) legend(label(1 "Magdalena") lab(2 "Bolívar") lab(3 "Media nacional")) graphregion(fcolor(white)) xtitle("años") ytitle("Número de personas alfabetas") ylabel(0(200000)1000000, alternate) title("Alfabetismo en el siglo XX")
graph export "alfabetismo_sXX.jpg", replace


*Asistencia escolar s. XIX
clear all
cls
cd "/Users/casa/Dropbox/00-SCHOOL/1-University/2021-20/1-Historia_Económica_de_Colombia/3-Investigación/8-Datos/Resultados/listos"
import excel  "/Users/casa/Dropbox/00-SCHOOL/1-University/2021-20/1-Historia_Económica_de_Colombia/3-Investigación/8-Datos/migracion_caribe-hec/raw/educacion_sXIX.xlsx", sheet("educacion") cellrange(A1:E89) firstrow 
egen id_depto=group(depto)
label define bolivar_magdalena 2 "Bolívar" 6 "Magdalena"
label values id_depto bolivar_magdalena
egen national_mean=mean(total_alumnos), by(ano)
egen mean_no_antioquia=mean(total_alumnos) if id_depto!=1, by(ano)
tset id_depto ano, y
gen prop_ninas=ninas/total_alumnos
egen prop_national_mean=mean(prop_ninas), by(ano)
twoway (tsline total_alumnos if id_depto==2) || (tsline total_alumnos if id_depto==6) || (tsline national_mean, lcolor(gs6)) || (tsline mean_no_antioquia, lpattern(shortdash)), scheme(s2mono) legend(lab(1 "Bolívar") lab(2 "Magdalena") lab(3 "Media nacional") lab(4 "Media sin Antioquia")) graphregion(fcolor(white)) xtitle("años") ytitle("Número de alumnos") title("Alumnos educación primaria por Estado")
graph export "total_alumnos_primaria-sXIX.jpg", replace
twoway (tsline prop_ninas if id_depto==2) || (tsline prop_ninas if id_depto==6) || (tsline prop_national_mean, lcolor(gs6)), scheme(s2mono) legend(lab(1 "Bolívar") lab(2 "Magdalena") lab(3 "Media nacional")) graphregion(fcolor(white)) xtitle("años") ytitle("Proporción niñas") title("Proporción alumnas en educación primaria")
graph export "prop_ninas_primaria-sXIX.jpg", replace
