Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FCED527
	for <gfs2@lists.linux.dev>; Tue,  5 Sep 2023 15:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693928463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UfnqfUWRcD9m8WUR5GiBpJG8YD4Cbc0Ive2hmh9ofaQ=;
	b=YFRSaWUw754FAh4oqOQ5oFq7LB8WCq4TBb0z0ox3c6ThZEFcFmQAaGDNQH8M7E1GgffHWv
	X0Bh99ENy/KOg5HufZ1ckcnYir6cL0mZZxGd180bsGJYpPZBJwYxmp+hX0k5+4XSlWtXC6
	+x5YB7WXVwQdgnegdaBHSxq0cc7KIp8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-544-ltnmO2mePEuAzJoh2fm-UQ-1; Tue, 05 Sep 2023 11:41:00 -0400
X-MC-Unique: ltnmO2mePEuAzJoh2fm-UQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0E361C0DB09
	for <gfs2@lists.linux.dev>; Tue,  5 Sep 2023 15:40:59 +0000 (UTC)
Received: from redhat.com (null.msp.redhat.com [10.15.80.136])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DBB8140E962;
	Tue,  5 Sep 2023 15:40:59 +0000 (UTC)
Date: Tue, 5 Sep 2023 10:40:56 -0500
From: David Teigland <teigland@redhat.com>
To: Andrew Price <anprice@redhat.com>
Cc: agruenba@redhat.com, rpeterso@redhat.com, ccaulfie@redhat.com,
	cluster-devel@redhat.com, gfs2@lists.linux.dev
Subject: Re: [PATCH 2/2] MAINTAINERS: Update dlm mailing list
Message-ID: <20230905154056.GA20620@redhat.com>
References: <20230831095749.9616-1-anprice@redhat.com>
 <20230831095749.9616-2-anprice@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230831095749.9616-2-anprice@redhat.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 31, 2023 at 10:57:49AM +0100, Andrew Price wrote:
> The new gfs2@ list will also be used for dlm development.
> 
> Signed-off-by: Andrew Price <anprice@redhat.com>

Ack, thanks.

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index caae31fb9741..946fcf6c8d77 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6093,7 +6093,7 @@ F:	include/video/udlfb.h
>  DISTRIBUTED LOCK MANAGER (DLM)
>  M:	Christine Caulfield <ccaulfie@redhat.com>
>  M:	David Teigland <teigland@redhat.com>
> -L:	cluster-devel@redhat.com
> +L:	gfs2@lists.linux.dev
>  S:	Supported
>  W:	http://sources.redhat.com/cluster/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git
> -- 
> 2.41.0

