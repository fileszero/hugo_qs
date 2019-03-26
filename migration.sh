#!/usr/bin/sh

echo "migrate Wordpress to HUGO"

hugoExport="/C/var/hugo/migration/wp-hugo/hugo-export/"
ls $hugoExport

for file in `find ${hugoExport%/}/posts -maxdepth 1 -type f -name "*.md"`; do
    fdir="${file%/*}"
    fname_ext="${file##*/}"
    fname="${fname_ext%.*}"
    slug=${fname:11}
    if [ -z "$slug" ]; then
        slug=`grep -i "^title:" $file | sed -e "s/^title: \(.*\)/\1/gi"`
    fi
    echo "fdir=[$fdir] fname_ext=[$fname_ext] fname=[$fname] slug=[$slug]"

    newdir=${fdir%/}/$fname
    idxfile=${newdir%/}/index.md

    echo "newdir=$newdir"
    echo "idxfile=$idxfile"
    mkdir -p "$newdir"
    \cp -f "$file" "$idxfile"

    # remove url
    sed -i -e "/^url:/d" $idxfile
    grep -iE "wp-content/uploads/.*.(png|jpg)" $idxfile | while read -r line ; do
        image=`echo $line |  sed -n -r 's/^.*a href="[^"]+\/wp-content\/uploads\/([^"]+(jpg|png))".*$/\1/p'`
        if [ -z "$image" ]; then
            image=`echo $line |  sed -n -r 's/^.*img.*src="[^"]+\/wp-content\/uploads\/([^"]+(jpg|png))".*$/\1/p'`
        fi
        if [ -z "$image" ]; then
            image=`echo $line |  sed -n -r 's/^.*featured_image: [^"]+\/wp-content\/uploads\/([^"]+(jpg|png)).*$/\1/p'`
        fi
        if [ -n "$image" ]; then
            image_ext="${image##*/}"
            \cp -v -f "${hugoExport%/}/wp-content/uploads/$image" "${newdir%/}/$image_ext"
            # replace image link
            imageSed=${image//\//\\/}
            echo "$imageSed"
            sed -i -e "s/<a href.*\/wp-content\/uploads\/$imageSed.*<\/a>/{{< luminous src=\"$image_ext\" >}}/g" $idxfile
        fi

    done
    # replace image link
    #sed -e 's/^.*a href="[^"]+\/wp-content\/uploads\/\".*alt=\"([^\"]*)\".*<\/a>/$imgCode/g" $hugoExport/posts/2018-11-12-jenkins-aspnet-mvc-cicd.md
    break
done
imgSrc="www.kimurak.net\/wordpress\/wp-content\/uploads\/"
imgCode="{{< lightbox src=\"\/images\/\1\" caption=\"\3\" >}}"

# sed -E "s/<a href=\"[^\"]*https?:\/\/$imgSrc([^\"]+\.(jpg|png))\".*alt=\"([^\"]*)\".*<\/a>/$imgCode/g" $hugoExport/posts/2018-11-12-jenkins-aspnet-mvc-cicd.md

#sed -e 's/a/b/g' $hugoExport/posts/2019-03-19-redmine-ticket-command.md