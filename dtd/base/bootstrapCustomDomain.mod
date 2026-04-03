<!-- ============================================================= -->
<!--                   BOOTSTRAP CUSTOM DOMAIN                     -->
<!-- ============================================================= -->

<!-- ============================================================= -->
<!--                    ELEMENT DECLARATIONS                       -->
<!-- ============================================================= -->

<!ENTITY % callout.content "(%section.cnt;)*">
<!ENTITY % callout.attributes
  "spectitle CDATA #IMPLIED
   color CDATA #IMPLIED
   rounded (yes | no | 0 | 1 | 2 | 3 | 4 | 5 | circle | pill) #IMPLIED
   outputclass CDATA #IMPLIED
   %univ-atts;">
<!ELEMENT callout %callout.content;>
<!ATTLIST callout %callout.attributes;>

<!-- ============================================================= -->
<!--                    SPECIALIZATION ATTRIBUTE DECLARATIONS      -->
<!-- ============================================================= -->

<!ATTLIST callout class CDATA "+ topic/section bootstrapCustom-d/callout ">
