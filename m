Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97271DE2CC;
	Tue,  7 Jan 2025 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736273959; cv=none; b=cudtu7al1Q5hQ0jAoSv3RDagZgQWSJRhhr4O/4WfmtjWeC/dvjPLWRGYFWNHJI/iv4AGq+mIh91GkdO4S45tFABJuQtgQsIqvZ2gYP3OAv1eOUoihBQKMZn8z3sTtbDJxaTpPGnKM8tKjr545B54pKgoKhwRBJV4OWGWwbvIJOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736273959; c=relaxed/simple;
	bh=KIKuoMafoPxh5xGEEtxXatRgrBPU/O0Xfc+oGj3wb+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iU5Y8f65M9oBWYkcm8c3/xGaJHhE64jpP+LkVj4CYWV3XaYV/R5JkiBgxObmILUjv05tqgxuTcXiuNavoOiddf4NWVDpD73/0plvpdNb+2aq1i3GpvqablYhzksDibrq6YrPm7OKKRmDfgtiGITKqxZgCwK8J+3/Ag/Jpvp6OYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=mm8HQQZN; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="mm8HQQZN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3DmkukbuRevIOBjE4QBoTKeMsq7GmwyU+sBXHK7+wbM=; b=mm8HQQZNGiEk9Rn7vg8LsogjbX
	D4WKXulESOek7NQ20G+3U+Ei5cTbtMWV8YOtdef6++rj4ChkCCdOgdQaWuFeWXH6l2DlmpRh6wKGG
	e6OoniQhQ6jwLvsvcGoOorGi+sYu8hZP7YV6kc6UGPd/voM7rYhLOCepmkiEP5ue1sygeBhoZsWcJ
	ejT0GDfZC79j0VjnHlhe0GPxNeaYzShsZMVRhUyJN3iDHioo0e4/5r8ZrFXuc0l4hVI2KrRjgulA6
	7f5N+NiqsDJVYSTT3BPi2LaRWG5qtlTMoI0CbM7z/tRH3jY3VqDmef1AlfQC/fPrJw88zee/66/Q9
	Y5JFSKww==;
Received: from 179-125-71-237-dinamico.pombonet.net.br ([179.125.71.237] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tVEAT-00Cpg1-Oo; Tue, 07 Jan 2025 19:19:06 +0100
Date: Tue, 7 Jan 2025 15:18:58 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Alexander Aring <aahringo@redhat.com>
Cc: gfs2@lists.linux.dev, David Teigland <teigland@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH] dlm: prevent NPD when writing a positive value to
 event_done
Message-ID: <Z31wEtweV8FlQsVA@quatroqueijos.cascardo.eti.br>
References: <20241220141913.1346301-1-cascardo@igalia.com>
 <CAK-6q+hV41=KuZfFUpmJgm8YX8GVxoWZKiA_gGNHWXopt2VpBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK-6q+hV41=KuZfFUpmJgm8YX8GVxoWZKiA_gGNHWXopt2VpBA@mail.gmail.com>

On Mon, Jan 06, 2025 at 11:14:35AM -0500, Alexander Aring wrote:
> Hi,
> 
> On Fri, Dec 20, 2024 at 9:28 AM Thadeu Lima de Souza Cascardo
> <cascardo@igalia.com> wrote:
> >
> > do_uevent returns the value written to event_done. In case it is a positive
> > value, new_lockspace would undo all the work, and lockspace would not be
> > set. __dlm_new_lockspace, however, would treat that positive value as a
> > success due to commit 8511a2728ab8 ("dlm: fix use count with multiple
> > joins").
> >
> > Down the line, device_create_lockspace would pass that NULL lockspace to
> > dlm_find_lockspace_local, leading to a NULL pointer dereference:
> >
> 
> This issue starts to be an issue since commit 4db41bf4f04f ("dlm:
> remove ls_local_handle from struct dlm_ls"). Before
> dlm_find_lockspace_local() was then returning NULL and
> device_create_lockspace() returned -ENOENT as it wasn't found a NULL
> lockspace handle, see [0].
> After the patch it dlm_find_lockspace_local() will end in a
> null-pointer dereference because we don't do this lookup of pointers
> when we already should have this pointer already.
> This behaviour is kind of weird (as it makes no sense to lookup NULL)
> and yes, I didn't see that when I wrote commit 4db41bf4f04f ("dlm:
> remove ls_local_handle from struct dlm_ls"). Just this commit signals
> us we do something stupid with the error handling.
> 
> May I ask you which user space software do you use? As for
> dlm_controld I can't see that there is a positive number case for
> telling the event_done attribute. [1]

I was just playing with it manually, that is, without dlm_controld. I was
writing down into configfs and sysfs manually while issuing ioctls and then
tripped over this NULL pointer dereference.

I see how commit 4db41bf4f04f ("dlm: remove ls_local_handle from struct
dlm_ls") leads to the NPD. In any case, I suppose the Fixes line could
either be the one I pointed to (since that is what leads to such positive
return values to undo lockspace creation and still be interpreted as
success) or 4db41bf4f04f, specially if we want to restrict the backports to
only the kernels with this latter commit.

Regards.
Cascardo.

> 
> Your patch is fine anyway as a positive event_done should not be
> handled as an error (so far I can say that from the current DLM UAPI
> spec). We might need to review the whole error handling here again as
> the caller is only interested if it failed or not. Even kernel
> lockspaces clear positive error codes to zero whereas user space (our
> case) doesn't do that.
> 
> - Alex
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git/tree/fs/dlm/user.c?h=dlm-6.9#n431
> [1] https://pagure.io/dlm/blob/main/f/dlm_controld/cpg.c#_1811
> 
